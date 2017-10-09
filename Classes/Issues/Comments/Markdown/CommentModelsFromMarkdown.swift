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

func createCommentAST(markdown: String) -> MMDocument? {
    guard markdown.characters.count > 0 else { return nil }
    let parser = MMParser(extensions: .gitHubFlavored)
    var error: NSError? = nil
    let document = parser.parseMarkdown(markdown, error: &error)
    if let error = error {
        print("Error parsing markdown: %@", error.localizedDescription)
    }
    return document
}

func emptyDescriptionModel(width: CGFloat) -> ListDiffable {
    let attributes = [
        .font: Styles.Fonts.body.addingTraits(traits: .traitItalic),
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
    options: GitHubMarkdownOptions
    ) -> [ListDiffable] {
    let emojiMarkdown = replaceGithubEmojiRegex(string: markdown)
    let replaceHTMLentities = emojiMarkdown.removingHTMLEntities

    guard let document = createCommentAST(markdown: replaceHTMLentities)
        else { return [emptyDescriptionModel(width: width)] }

    var results = [ListDiffable]()

    let baseAttributes: [NSAttributedStringKey: Any] = [
        .font: Styles.Fonts.body,
        .foregroundColor: Styles.Colors.Gray.dark.color,
        .paragraphStyle: {
            let para = NSMutableParagraphStyle()
            para.paragraphSpacingBefore = 12;
            return para
        }(),
        NSAttributedStringKey.backgroundColor: UIColor.white,
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
            results: &results
        )
    }

    // add any remaining text
    if let text = createTextModel(attributedString: seedString, width: width, options: options) {
        results.append(text)
    }

    return results
}

func createTextModel(
    attributedString: NSAttributedString,
    width: CGFloat,
    options: GitHubMarkdownOptions
    ) -> NSAttributedStringSizing? {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    guard trimmedString.length > 0 else { return nil }
    return createTextModelUpdatingGitHubFeatures(
        attributedString: trimmedString,
        width: width,
        inset: IssueCommentTextCell.inset,
        options: options
    )
}

func createQuoteModel(
    level: Int,
    attributedString: NSAttributedString,
    width: CGFloat,
    options: GitHubMarkdownOptions
    ) -> IssueCommentQuoteModel {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    let text = createTextModelUpdatingGitHubFeatures(
        attributedString: trimmedString,
        width: width,
        inset: IssueCommentQuoteCell.inset(quoteLevel: level),
        options: options
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
    results: inout [ListDiffable]
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
                options: options
            ))
        } else if let text = createTextModel(attributedString: attributedString, width: width, options: options) {
            results.append(text)
        }
        attributedString.removeAll()
    }

    if element.type == .none || element.type == .entity || element.type == .mailTo {
        let substring = substringOrNewline(text: markdown, range: element.range)

        // hack: dont allow newlines within lists
        if substring != newlineString || listLevel == 0 {
            attributedString.append(NSAttributedString(string: substring, attributes: pushedAttributes))
        }
    } else if element.type == .listItem {
        // append list styles at the beginning of each list item
        let isInsideBulletedList = element.parent?.type == .bulletedList
        let modifier: String
        if isInsideBulletedList {
            let bullet = listLevel % 2 == 0 ? Strings.bulletHollow : Strings.bullet
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
        if let text = createTextModel(attributedString: attributedString, width: width, options: options) {
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
                results: &results
            )
        }
    }

    // cap the child before exiting
    if isQuote && attributedString.length > 0 {
        results.append(createQuoteModel(
            level: nextQuoteLevel,
            attributedString: attributedString,
            width: width,
            options: options
        ))
        attributedString.removeAll()
    }
}

private let usernameRegex = try! NSRegularExpression(pattern: "\\B@([a-zA-Z0-9_-]+)", options: [])
func updateUsernames(
    attributedString: NSAttributedString,
    options: GitHubMarkdownOptions
    ) -> NSAttributedString {
    guard options.flavors.contains(.usernames) else { return attributedString }

    let string = attributedString.string
    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
    let matches = usernameRegex.matches(in: string, options: [], range: string.nsrange)

    for match in matches {
        let range = match.range(at: 0)
        guard let substring = string.substring(with: range) else { continue }

        var attributes = attributedString.attributes(at: range.location, effectiveRange: nil)

        // manually disable username highlighting for some text (namely code)
        guard attributes[MarkdownAttribute.usernameDisabled] == nil else { continue }

        let font = attributes[.font] as? UIFont ?? Styles.Fonts.body
        attributes[.font] = font.addingTraits(traits: .traitBold)
        attributes[MarkdownAttribute.username] = substring.replacingOccurrences(of: "@", with: "")

        let usernameAttributedString = NSAttributedString(string: substring, attributes: attributes)
        mutableAttributedString.replaceCharacters(in: range, with: usernameAttributedString)
    }
    return mutableAttributedString
}

private let issueShorthandRegex = try! NSRegularExpression(pattern: "(^|\\s)((\\w+)/(\\w+))?#([0-9]+)", options: [])
func updateIssueShorthand(
    attributedString: NSAttributedString,
    options: GitHubMarkdownOptions
    ) -> NSAttributedString {
    guard options.flavors.contains(.issueShorthand) else { return attributedString }

    let string = attributedString.string
    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
    let matches = issueShorthandRegex.matches(in: string, options: [], range: string.nsrange)

    for match in matches {
        let ownerRange = match.range(at: 3)
        let repoRange = match.range(at: 4)
        let numberRange = match.range(at: 5)
        guard let numberSubstring = string.substring(with: numberRange) else { continue }

        var attributes = attributedString.attributes(at: match.range.location, effectiveRange: nil)
        attributes[.foregroundColor] = Styles.Colors.Blue.medium.color

        attributes[MarkdownAttribute.issue] = IssueDetailsModel(
            owner: string.substring(with: ownerRange) ?? options.owner,
            repo: string.substring(with: repoRange) ?? options.repo,
            number: (numberSubstring as NSString).integerValue
        )

        mutableAttributedString.setAttributes(attributes, range: match.range)
    }
    return mutableAttributedString
}

func createTextModelUpdatingGitHubFeatures(
    attributedString: NSAttributedString,
    width: CGFloat,
    inset: UIEdgeInsets,
    options: GitHubMarkdownOptions
    ) -> NSAttributedStringSizing {

    let usernames = updateUsernames(attributedString: attributedString, options: options)
    let issues = updateIssueShorthand(attributedString: usernames, options: options)

    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: issues,
        inset: inset
    )
}
