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
import StyledText

private let newlineString = "\n"

struct GitHubFlavors: OptionSet {
    let rawValue: Int

//    static let usernames = GitHubFlavors(rawValue: 1)
//    static let issueShorthand = GitHubFlavors(rawValue: 2)
    static let baseURL = GitHubFlavors(rawValue: 3)

}

struct GitHubMarkdownOptions {
    let owner: String
    let repo: String
    let flavors: [GitHubFlavors]
    let width: CGFloat
    let contentSizeCategory: UIContentSizeCategory
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

func emptyDescriptionModel(options: GitHubMarkdownOptions) -> ListDiffable {
    let builder = StyledTextBuilder(styledText: StyledText(
        style: Styles.Text.body
    )).add(text: NSLocalizedString("No description provided.", comment: ""), traits: .traitItalic)
    return StyledTextRenderer(
        string: builder.build(),
        contentSizeCategory: options.contentSizeCategory,
        inset: IssueCommentTextCell.inset
    )
}

func CreateCommentModels(
    markdown: String,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool = false
    ) -> [ListDiffable] {

    // TODO remove after testing
    return MarkdownModels(markdown, owner: options.owner, repo: options.repo, width: options.width, viewerCanUpdate: viewerCanUpdate, contentSizeCategory: options.contentSizeCategory)

    let emojiMarkdown = markdown.replacingGithubEmojiRegex
    let replaceHTMLentities = emojiMarkdown.removingHTMLEntities

    guard let document = createCommentAST(
        markdown: replaceHTMLentities,
        owner: options.owner,
        repository: options.repo
        ) else { return [emptyDescriptionModel(options: options)] }

    var results = [ListDiffable]()
    let builder = StyledTextBuilder.markdownBase()
    
    for element in document.elements {
        travelAST(
            markdown: document.markdown,
            element: element,
            builder: builder,
            listLevel: 0,
            quoteLevel: 0,
            options: options,
            results: &results,
            viewerCanUpdate: viewerCanUpdate
        )
    }

    // add any remaining text
    if let text = createTextModel(
        string: builder.build(),
        options: options,
        viewerCanUpdate: viewerCanUpdate
        ) {
        results.append(text)
    }

    return results
}

func createTextModel(
    string: StyledTextString,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool
    ) -> StyledTextRenderer? {
    return createTextModelUpdatingGitHubFeatures(
        string: string,
        inset: IssueCommentTextCell.inset,
        options: options,
        viewerCanUpdate: viewerCanUpdate
    )
}

func createQuoteModel(
    level: Int,
    string: StyledTextString,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool
    ) -> IssueCommentQuoteModel? {
    guard let text = createTextModelUpdatingGitHubFeatures(
        string: string,
        inset: IssueCommentQuoteCell.inset(quoteLevel: level),
        options: options,
        viewerCanUpdate: viewerCanUpdate
        ) else { return nil }
    return IssueCommentQuoteModel(level: level, string: text)
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
        return CreateImageModel(href: element.href)
    case .table:
        return CreateTable(element: element, markdown: markdown, contentSizeCategory: options.contentSizeCategory)
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
    builder: StyledTextBuilder,
    listLevel: Int,
    quoteLevel: Int,
    options: GitHubMarkdownOptions,
    results: inout [ListDiffable],
    viewerCanUpdate: Bool
    ) {
    builder.save()
    defer {
        builder.restore()
    }

    let nextListLevel = listLevel + (isList(type: element.type) ? 1 : 0)
    let isQuote = element.type == .blockquote
    let nextQuoteLevel = quoteLevel + (isQuote ? 1 : 0)

    // push more text attributes on the stack the deeper we go
    PushAttributes(element: element, builder: builder, listLevel: nextListLevel)

    if needsNewline(element: element) {
        builder.add(text: newlineString)
    }

    // if entering a block quote, finish up any string that was building
    if isQuote && builder.count > 0 {
        if quoteLevel > 0 {
            if let quote = createQuoteModel(
                level: quoteLevel,
                string: builder.build(),
                options: options,
                viewerCanUpdate: viewerCanUpdate
                ) {
                results.append(quote)
            }
        } else if let text = createTextModel(
            string: builder.build(),
            options: options,
            viewerCanUpdate: viewerCanUpdate
            ) {
            results.append(text)
        }
        builder.clearText()
    }

    if element.type == .none
        || element.type == .entity
        || element.type == .mailTo
        || element.type == .username
        || element.type == .shorthandIssues {
        let substring = substringOrNewline(text: markdown, range: element.range)

        // hack: dont allow newlines within lists
        if substring != newlineString || listLevel == 0 {
            builder.add(text: substring)
        }
    } else if element.type == .shortenedLink, let owner = element.owner, let repo = element.repository {
        let text: String
        if owner == options.owner && repo == options.repo {
            text = "#\(element.number)"
        } else {
            text = "\(owner)/\(repo)#\(element.number)"
        }
        builder.add(text: text)
    } else if element.type == .checkbox {
        builder.addCheckbox(
            checked: element.checked,
            range: element.range,
            viewerCanUpdate: viewerCanUpdate
        )
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
        builder.add(text: modifier)
    }

    let model = createModel(markdown: markdown, element: element, options: options)

    // if a model exists, push a new model with the current text stack _before_ the model. remember to drain the text
    if let model = model {
        if let text = createTextModel(
            string: builder.build(),
            options: options,
            viewerCanUpdate: viewerCanUpdate
            ) {
            results.append(text)
        }
        results.append(model)
        builder.clearText()
    } else {
        for child in element.children {
            travelAST(
                markdown: markdown,
                element: child,
                builder: builder,
                listLevel: nextListLevel,
                quoteLevel: nextQuoteLevel,
                options: options,
                results: &results,
                viewerCanUpdate: viewerCanUpdate
            )
        }
    }

    // cap the child before exiting
    if isQuote && builder.count > 0 {
        if let quote = createQuoteModel(
            level: nextQuoteLevel,
            string: builder.build(),
            options: options,
            viewerCanUpdate: viewerCanUpdate
            ) {
            results.append(quote)
            builder.clearText()
        }
    }
}

func createTextModelUpdatingGitHubFeatures(
    string: StyledTextString,
    inset: UIEdgeInsets,
    options: GitHubMarkdownOptions,
    viewerCanUpdate: Bool
    ) -> StyledTextRenderer? {
    guard !string.allText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return nil }
    return StyledTextRenderer(
        string: string,
        contentSizeCategory: options.contentSizeCategory,
        inset: inset,
        backgroundColor: .white
        ).warm(width: options.width)
}
