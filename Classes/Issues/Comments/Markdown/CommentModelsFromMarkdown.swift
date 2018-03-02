//
//  CommentModelsFromMarkdown.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import MMMarkdown
import HTMLString

private let newlineString = "\n"

struct GitHubFlavors: OptionSet {
    let rawValue: Int

    static let usernames = GitHubFlavors(rawValue: 1)
    static let issueShorthand = GitHubFlavors(rawValue: 2)
    static let baseURL = GitHubFlavors(rawValue: 3)

}

struct GitHubMarkdownOptions {
    let owner: String
    let repo: String
    let flavors: [GitHubFlavors]
}

func createCommentAST(markdown: String, owner: String, repository: String) -> MMDocument? {
    guard !markdown.isEmpty else { return nil }
    let parser = MMParser(extensions: .gitHubFlavored, owner: owner, repository: repository)
    var error: NSError? = nil
    let document = parser.parseMarkdown(markdown, error: &error)
    if let error = error {
        print("Error parsing markdown: %@", error.localizedDescription)
    }
    return document
}

func emptyDescriptionModel(width: CGFloat) -> ListDiffable {
    let attributes = [
        .font: Styles.Text.body.preferredFont.addingTraits(traits: .traitItalic),
        .foregroundColor: Styles.Colors.Gray.medium.color,
        NSAttributedStringKey.backgroundColor: UIColor.white
    ]
    let text = NSAttributedString(
        string: NSLocalizedString("No description provided.", comment: ""),
        attributes: attributes
    )
    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: text,
        inset: IssueCommentTextCell.inset
    )
}

func CreateCommentModels(
    markdown: String,
    width: CGFloat,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool = false
    ) -> [ListDiffable] {

    let emojiMarkdown = replaceGithubEmojiRegex(string: markdown)
    let replaceHTMLentities = emojiMarkdown.removingHTMLEntities

    guard let document = createCommentAST(
        markdown: replaceHTMLentities,
        owner: options.owner,
        repository: options.repo
        ) else { return [emptyDescriptionModel(width: width)] }

    var results = [ListDiffable]()

    let baseAttributes: [NSAttributedStringKey: Any] = [
        .font: Styles.Text.body.preferredFont,
        .foregroundColor: Styles.Colors.Gray.dark.color,
        .paragraphStyle: {
            let para = NSMutableParagraphStyle()
            para.paragraphSpacingBefore = 12
            return para
        }(),
        NSAttributedStringKey.backgroundColor: UIColor.white
    ]

    let seedString = NSMutableAttributedString()
    
    for element in document.elements {
        travelAST(
            markdown: document.markdown,
            element: element,
            attributedString: seedString,
            attributeStack: baseAttributes,
            width: width,
            listLevel: 0,
            quoteLevel: 0,
            options: options,
            results: &results,
            viewerCanUpdate: viewerCanUpdate
        )
    }

    // add any remaining text
    if let text = createTextModel(
        attributedString: seedString,
        width: width,
        options: options,
        viewerCanUpdate: viewerCanUpdate
        ) {
        results.append(text)
    }

    return results
}

func createTextModel(
    attributedString: NSAttributedString,
    width: CGFloat,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool
    ) -> NSAttributedStringSizing? {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    guard trimmedString.length > 0 else { return nil }
    return createTextModelUpdatingGitHubFeatures(
        attributedString: trimmedString,
        width: width,
        inset: IssueCommentTextCell.inset,
        options: options,
        viewerCanUpdate: viewerCanUpdate
    )
}

func createQuoteModel(
    level: Int,
    attributedString: NSAttributedString,
    width: CGFloat,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool
    ) -> IssueCommentQuoteModel {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    let text = createTextModelUpdatingGitHubFeatures(
        attributedString: trimmedString,
        width: width,
        inset: IssueCommentQuoteCell.inset(quoteLevel: level),
        options: options,
        viewerCanUpdate: viewerCanUpdate
    )
    return IssueCommentQuoteModel(level: level, quote: text)
}

func substringOrNewline(text: String, range: NSRange) -> String {
    let substring = text.substring(with: range) ?? ""
    if !substring.isEmpty {
        return substring
    } else {
        return newlineString
    }
}

func needsNewline(element: MMElement) -> Bool {
    switch element.type {
    case .paragraph: return element.parent?.type != .listItem
    case .listItem: return true
    case .header: return true
    default: return false
    }
}

func createModel(
    markdown: String,
    element: MMElement,
    options: GitHubMarkdownOptions
    ) -> ListDiffable? {
    switch element.type {
    case .codeBlock:
        return CreateCodeBlock(element: element, markdown: markdown)
    case .image:
        return CreateImageModel(element: element)
    case .table:
        return CreateTable(element: element, markdown: markdown)
    case .HTML:
        guard let html = markdown.substring(with: element.range)?.trimmingCharacters(in: .whitespacesAndNewlines),
            !html.isEmpty
            else { return nil }

        let baseURL: URL?
        if options.flavors.contains(.baseURL) {
            // TODO: REVISE
            baseURL = URL(string: "https://github.com/\(options.owner)/\(options.repo)/raw/master/")
        } else {
            baseURL = nil
        }

        return IssueCommentHtmlModel(html: html, baseURL: baseURL)
    case .horizontalRule:
        return IssueCommentHrModel()
    default: return nil
    }
}

func isList(type: MMElementType) -> Bool {
    switch type {
    case .bulletedList, .numberedList: return true
    default: return false
    }
}

func travelAST(
    markdown: String,
    element: MMElement,
    attributedString: NSMutableAttributedString,
    attributeStack: [NSAttributedStringKey: Any],
    width: CGFloat,
    listLevel: Int,
    quoteLevel: Int,
    options: GitHubMarkdownOptions,
    results: inout [ListDiffable],
    viewerCanUpdate: Bool
    ) {
    let nextListLevel = listLevel + (isList(type: element.type) ? 1 : 0)

    let isQuote = element.type == .blockquote
    let nextQuoteLevel = quoteLevel + (isQuote ? 1 : 0)

    // push more text attributes on the stack the deeper we go
    let pushedAttributes = PushAttributes(
        element: element,
        current: attributeStack,
        listLevel: nextListLevel
    )

    if needsNewline(element: element) {
        attributedString.append(NSAttributedString(string: newlineString, attributes: pushedAttributes))
    }

    // if entering a block quote, finish up any string that was building
    if isQuote && attributedString.length > 0 {
        if quoteLevel > 0 {
            results.append(createQuoteModel(
                level: quoteLevel,
                attributedString: attributedString,
                width: width,
                options: options,
                viewerCanUpdate: viewerCanUpdate
            ))
        } else if let text = createTextModel(
            attributedString: attributedString,
            width: width,
            options: options,
            viewerCanUpdate: viewerCanUpdate
            ) {
            results.append(text)
        }
        attributedString.removeAll()
    }

    if element.type == .none
        || element.type == .entity
        || element.type == .mailTo
        || element.type == .username
        || element.type == .shorthandIssues {
        let substring = substringOrNewline(text: markdown, range: element.range)

        // hack: dont allow newlines within lists
        if substring != newlineString || listLevel == 0 {
            attributedString.append(NSAttributedString(string: substring, attributes: pushedAttributes))
        }
    } else if element.type == .checkbox {
        let appendDisabled = viewerCanUpdate ? "" : "-disabled"
        if let image = UIImage(named: (element.checked ? "checked" : "unchecked") + appendDisabled) {
            let attachment = NSTextAttachment()
            attachment.image = image
            // nudge bounds to align better with baseline text
            attachment.bounds = CGRect(x: 0, y: -2, width: image.size.width, height: image.size.height)

            if let attachmentString = NSAttributedString(attachment: attachment).mutableCopy() as? NSMutableAttributedString {
                attachmentString.addAttribute(
                    MarkdownAttribute.checkbox,
                    value: MarkdownCheckboxModel(checked: element.checked, originalMarkdownRange: element.range),
                    range: attachmentString.string.nsrange
                )
                attributedString.append(attachmentString)
                attributedString.append(NSAttributedString(string: " ", attributes: pushedAttributes))
            }
        }
    } else if element.type == .listItem {
        // append list styles at the beginning of each list item
        let isInsideBulletedList = element.parent?.type == .bulletedList
        let modifier: String
        if isInsideBulletedList {
            let bullet = listLevel % 2 == 0 ? Constants.Strings.bulletHollow : Constants.Strings.bullet
            modifier = "\(bullet) "
        } else if element.numberedListPosition > 0 {
            modifier = "\(element.numberedListPosition). "
        } else {
            modifier = ""
        }
        attributedString.append(NSAttributedString(string: modifier, attributes: pushedAttributes))
    }

    let model = createModel(markdown: markdown, element: element, options: options)

    // if a model exists, push a new model with the current text stack _before_ the model. remember to drain the text
    if let model = model {
        if let text = createTextModel(
            attributedString: attributedString,
            width: width,
            options: options,
            viewerCanUpdate: viewerCanUpdate
            ) {
            results.append(text)
        }
        results.append(model)
        attributedString.removeAll()
    } else {
        for child in element.children {
            travelAST(
                markdown: markdown,
                element: child,
                attributedString: attributedString,
                attributeStack: pushedAttributes,
                width: width,
                listLevel: nextListLevel,
                quoteLevel: nextQuoteLevel,
                options: options,
                results: &results,
                viewerCanUpdate: viewerCanUpdate
            )
        }
    }

    // cap the child before exiting
    if isQuote && attributedString.length > 0 {
        results.append(createQuoteModel(
            level: nextQuoteLevel,
            attributedString: attributedString,
            width: width,
            options: options,
            viewerCanUpdate: viewerCanUpdate
        ))
        attributedString.removeAll()
    }
}

// TODO: REVISE
private let issueURLRegex = try! NSRegularExpression(pattern: "https?:\\/\\/.*github.com\\/(\\w*)\\/([^/]*?)\\/issues\\/([0-9]+)", options: [])
func shortenGitHubLinks(attributedString: NSAttributedString,
                        options: GitHubMarkdownOptions) -> NSAttributedString {

    guard options.flavors.contains(.issueShorthand) else { return attributedString }

    let string = attributedString.string
    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
    let matches = issueURLRegex.matches(in: string, options: [], range: string.nsrange)

    for match in matches.reversed() {
        let ownerRange = match.range(at: 1)
        let repoRange = match.range(at: 2)
        let numberRange = match.range(at: 3)

        guard let ownerSubstring = string.substring(with: ownerRange),
              let repoSubstring = string.substring(with: repoRange),
              let numberSubstring = string.substring(with: numberRange) else { continue }

        var attributes = attributedString.attributes(at: match.range.location, effectiveRange: nil)

        // manually disable link shortening for some text (namely code)
        guard attributes[MarkdownAttribute.linkShorteningDisabled] == nil else { continue }

        attributes[.foregroundColor] = Styles.Colors.Blue.medium.color
        attributes[MarkdownAttribute.issue] = IssueDetailsModel(
            owner: ownerSubstring,
            repo: repoSubstring,
            number: (numberSubstring as NSString).integerValue
        )
        attributes[MarkdownAttribute.url] = nil

        var shortenedText: String

        if ownerSubstring == options.owner && repoSubstring == options.repo {
            shortenedText = "#\(numberSubstring)"
        } else {
            shortenedText = "\(ownerSubstring)/\(repoSubstring)#\(numberSubstring)"
        }

        let linkAttributedString = NSAttributedString(string: shortenedText, attributes: attributes)
        mutableAttributedString.replaceCharacters(in: match.range, with: linkAttributedString)
    }

    return mutableAttributedString
}

func createTextModelUpdatingGitHubFeatures(
    attributedString: NSAttributedString,
    width: CGFloat,
    inset: UIEdgeInsets,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool
    ) -> NSAttributedStringSizing {

    let shorten = shortenGitHubLinks(attributedString: attributedString, options: options)

    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: shorten,
        inset: inset
    )
}
