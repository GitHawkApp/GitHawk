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

private let newlineString = "\n"

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
        NSFontAttributeName: Styles.Fonts.body.addingTraits(traits: .traitItalic),
        NSForegroundColorAttributeName: Styles.Colors.Gray.medium.color,
        NSBackgroundColorAttributeName: UIColor.white
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
    owner: String? = nil,
    repo: String? = nil
    ) -> [ListDiffable] {
    let emojiMarkdown = replaceGithubEmojiRegex(string: markdown)

    guard let document = createCommentAST(markdown: emojiMarkdown)
        else { return [emptyDescriptionModel(width: width)] }

    var results = [ListDiffable]()

    let baseAttributes: [String: Any] = [
        NSFontAttributeName: Styles.Fonts.body,
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
        NSParagraphStyleAttributeName: {
            let para = NSMutableParagraphStyle()
            para.paragraphSpacingBefore = 12;
            return para
        }(),
        NSBackgroundColorAttributeName: UIColor.white,
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
            owner: owner,
            repo: repo,
            results: &results
        )
    }

    // add any remaining text
    if let text = createTextModel(attributedString: seedString, width: width, owner: owner, repo: repo) {
        results.append(text)
    }

    return results
}

func createTextModel(
    attributedString: NSAttributedString,
    width: CGFloat,
    owner: String?,
    repo: String?
    ) -> NSAttributedStringSizing? {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    guard trimmedString.length > 0 else { return nil }
    return createTextModelUpdatingGitHubFeatures(
        attributedString: trimmedString,
        width: width,
        inset: IssueCommentTextCell.inset,
        owner: owner,
        repo: repo
    )
}

func createQuoteModel(
    level: Int,
    attributedString: NSAttributedString,
    width: CGFloat,
    owner: String?,
    repo: String?
    ) -> IssueCommentQuoteModel {
    // remove head/tail whitespace and newline from text blocks
    let trimmedString = attributedString
        .attributedStringByTrimmingCharacterSet(charSet: .whitespacesAndNewlines)
    let text = createTextModelUpdatingGitHubFeatures(
        attributedString: trimmedString,
        width: width,
        inset: IssueCommentQuoteCell.inset(quoteLevel: level),
        owner: owner,
        repo: repo
    )
    return IssueCommentQuoteModel(level: level, quote: text)
}

func substringOrNewline(text: String, range: NSRange) -> String {
    let substring = text.substring(with: range) ?? ""
    if substring.characters.count > 0 {
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

func createModel(markdown: String, element: MMElement, owner: String?, repo: String?) -> ListDiffable? {
    switch element.type {
    case .codeBlock:
        return CreateCodeBlock(element: element, markdown: markdown)
    case .image:
        return CreateImageModel(element: element)
    case .table:
        return CreateTable(element: element, markdown: markdown)
    case .HTML:
        guard let html = markdown.substring(with: element.range)?.trimmingCharacters(in: .whitespacesAndNewlines),
            html.characters.count > 0
            else { return nil }
        
        let baseURL: URL? = {
            guard let owner = owner, let repo = repo else { return nil }
            return URL(string: "https://github.com/\(owner)/\(repo)/raw/master")
        }()
        
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
    attributeStack: [String: Any],
    width: CGFloat,
    listLevel: Int,
    quoteLevel: Int,
    owner: String?,
    repo: String?,
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
                owner: owner,
                repo: repo
            ))
        } else if let text = createTextModel(attributedString: attributedString, width: width, owner: owner, repo: repo) {
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

    let model = createModel(markdown: markdown, element: element, owner: owner, repo: repo)

    // if a model exists, push a new model with the current text stack _before_ the model. remember to drain the text
    if let model = model {
        if let text = createTextModel(attributedString: attributedString, width: width, owner: owner, repo: repo) {
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
                owner: owner,
                repo: repo,
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
            owner: owner,
            repo: repo
        ))
        attributedString.removeAll()
    }
}

private let usernameRegex = try! NSRegularExpression(pattern: "\\B@([a-zA-Z0-9_-]+)", options: [])
func updateUsernames(attributedString: NSAttributedString) -> NSAttributedString {
    let string = attributedString.string
    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
    let matches = usernameRegex.matches(in: string, options: [], range: string.nsrange)

    for match in matches {
        let range = match.rangeAt(0)
        guard let substring = string.substring(with: range) else { continue }

        var attributes = attributedString.attributes(at: range.location, effectiveRange: nil)

        // manually disable username highlighting for some text (namely code)
        guard attributes[MarkdownAttribute.usernameDisabled] == nil else { continue }

        let font = attributes[NSFontAttributeName] as? UIFont ?? Styles.Fonts.body
        attributes[NSFontAttributeName] = font.addingTraits(traits: .traitBold)
        attributes[MarkdownAttribute.username] = substring.replacingOccurrences(of: "@", with: "")

        let usernameAttributedString = NSAttributedString(string: substring, attributes: attributes)
        mutableAttributedString.replaceCharacters(in: range, with: usernameAttributedString)
    }
    return mutableAttributedString
}

private let issueShorthandRegex = try! NSRegularExpression(pattern: "\\B#([0-9]+)", options: [])
func updateIssueShorthand(
    attributedString: NSAttributedString,
    owner: String?,
    repo: String?
    ) -> NSAttributedString {
    guard let owner = owner, let repo = repo else { return attributedString }

    let string = attributedString.string
    let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
    let matches = issueShorthandRegex.matches(in: string, options: [], range: string.nsrange)

    for match in matches {
        let range = match.rangeAt(0)
        guard let substring = string.substring(with: range) else { continue }

        var attributes = attributedString.attributes(at: range.location, effectiveRange: nil)
        attributes[NSForegroundColorAttributeName] = Styles.Colors.Blue.medium.color

        let number = (substring.replacingOccurrences(of: "#", with: "") as NSString).integerValue
        attributes[MarkdownAttribute.issue] = IssueDetailsModel(owner: owner, repo: repo, number: number)
        
        mutableAttributedString.replaceCharacters(
            in: range,
            with: NSAttributedString(string: substring, attributes: attributes)
        )
    }
    return mutableAttributedString
}

func createTextModelUpdatingGitHubFeatures(
    attributedString: NSAttributedString,
    width: CGFloat,
    inset: UIEdgeInsets,
    owner: String?,
    repo: String?
    ) -> NSAttributedStringSizing {

    let usernames = updateUsernames(attributedString: attributedString)
    let issues = updateIssueShorthand(attributedString: usernames, owner: owner, repo: repo)

    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: issues,
        inset: inset
    )
}
