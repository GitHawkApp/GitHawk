//
//  CMarkParsing.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/31/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledText
import cmark_gfm_swift
import IGListKit
import HTMLString

private struct CMarkOptions {
    let owner: String
    let repo: String
    let branch: String?
    let width: CGFloat
    let viewerCanUpdate: Bool
    let contentSizeCategory: UIContentSizeCategory
}

private struct CMarkContext {
    let inLink: Bool
    init(inLink: Bool = false) {
        self.inLink = inLink
    }
}

private extension TextElement {
    @discardableResult
    func build(
        _ builder: StyledTextBuilder,
        options: CMarkOptions,
        context: CMarkContext
        ) -> StyledTextBuilder {
        builder.save()
        defer { builder.restore() }

        switch self {
        case .text(let text):
            // if inside a link, attempt to shorten it if its an owner+repo+issue link
            if context.inLink, let shortlink = text.shortlinkInfo {
                let linkText: String
                // if the owner/repo match, just use "#123" shorthand
                if shortlink.owner.lowercased() == options.owner.lowercased(),
                    shortlink.repo.lowercased() == options.repo.lowercased() {
                    linkText = "#\(shortlink.number)"
                } else {
                    linkText = "\(shortlink.owner)/\(shortlink.repo)#\(shortlink.number)"
                }
                builder.add(text: linkText)
            } else {
                text.detectAndHandleShortlink(owner: options.owner, repo: options.repo, builder: builder)
            }
        case .softBreak, .lineBreak:
            builder.add(text: "\n")
        case .code(let text):
            builder.add(styledText: StyledText(
                text: text,
                style: Styles.Text.code.with(background: Styles.Colors.Gray.lighter.color)
            ))
        case .emphasis(let children):
            builder.add(traits: .traitItalic)
            children.build(builder, options: options, context: context)
        case .strong(let children):
            builder.add(traits: .traitBold)
            children.build(builder, options: options, context: context)
        case .strikethrough(let children):
            builder.add(attributes: [
                .strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
                .strikethroughColor: builder.tipAttributes?[.foregroundColor] ?? Styles.Colors.Gray.dark.color
                ])
            children.build(builder, options: options, context: context)
        case .link(let children, _, let url):
            var attributes: [NSAttributedStringKey: Any] = [.foregroundColor: Styles.Colors.Blue.medium.color]
            if let shortlink = url?.shortlinkInfo {
                attributes[MarkdownAttribute.issue] = IssueDetailsModel(
                    owner: shortlink.owner,
                    repo: shortlink.repo,
                    number: shortlink.number
                )
            } else {
                attributes[MarkdownAttribute.url] = url ?? ""
            }
            builder.add(attributes: attributes)
            children.build(builder, options: options, context: CMarkContext(inLink: true))
        case .mention(let login):
            builder.add(text: "@\(login)", traits: .traitBold, attributes: [MarkdownAttribute.username: login])
        case .checkbox(let checked, let originalRange):
            builder.addCheckbox(checked: checked, range: originalRange, viewerCanUpdate: options.viewerCanUpdate)
        }
        return builder
    }
}

private extension Sequence where Iterator.Element == TextElement {
    @discardableResult
    func build(
        _ builder: StyledTextBuilder,
        options: CMarkOptions,
        context: CMarkContext
        ) -> StyledTextBuilder {
        forEach { $0.build(builder, options: options, context: context) }
        return builder
    }
}

private extension ListElement {
    @discardableResult
    func build(_ builder: StyledTextBuilder, options: CMarkOptions) -> StyledTextBuilder {
        switch self {
        case .text(let text):
            text.build(builder, options: options, context: CMarkContext())
        case .list(let children, let type, let level):
            children.build(builder, options: options, type: type, level: level)
        }
        return builder
    }
}

private extension Array {
    func forEach(_ body: (Element) -> Void, joined: (Element) -> Void) {
        for (i, e) in enumerated() {
            body(e)
            if i != count - 1 {
                joined(e)
            }
        }
    }
}

private extension Array where Iterator.Element == TextLine {
    @discardableResult
    func build(_ builder: StyledTextBuilder, options: CMarkOptions) -> StyledTextBuilder {
        forEach({ el in
            el.build(builder, options: options, context: CMarkContext())
        }, joined: { _ in
            builder.add(text: "\n")
        })
        return builder
    }
}

private extension Array where Iterator.Element == [ListElement] {
    @discardableResult
    func build(
        _ builder: StyledTextBuilder,
        options: CMarkOptions,
        type: ListType,
        level: Int
        ) -> StyledTextBuilder {
        builder.save()
        defer { builder.restore() }

        let paragraphStyle = ((builder.tipAttributes?[.paragraphStyle] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle)
            ?? NSMutableParagraphStyle()
        paragraphStyle.firstLineHeadIndent = CGFloat(level) * 18

        for (i, c) in enumerated() {
            // tighten spacing for the list after the first paragraph
            if i > 0 || level > 0 {
                paragraphStyle.paragraphSpacingBefore = 2
            }

            let tick: String
            switch type {
            case .ordered:
                tick = "\(i + 1)."
            case .unordered:
                tick = level % 2 == 0
                    ? Constants.Strings.bullet
                    : Constants.Strings.bulletHollow
            }
            builder.add(text: "\(tick) ", attributes: [.paragraphStyle: paragraphStyle])

            c.forEach({ cc in
                cc.build(builder, options: options)
            }, joined: { _ in
                builder.add(text: "\n")
            })

            // never append whitespace on the last element
            if i != count - 1 {
                builder.add(text: "\n")
            }
        }
        return builder
    }
}

private extension TableRow {
    func build(options: CMarkOptions, greyBackground: Bool) -> [StyledTextRenderer] {
        let backgroundColor: UIColor = greyBackground ? Styles.Colors.Gray.lighter.color : .white
        let builders: [StyledTextBuilder]
        switch self {
        case .header(let cells):
            builders = cells.map {
                $0.build(
                    StyledTextBuilder.markdownBase().add(traits: .traitBold),
                    options: options,
                    context: CMarkContext()
                )
            }
        case .row(let cells):
            builders = cells.map {
                $0.build(
                    StyledTextBuilder.markdownBase().add(attributes: [.backgroundColor: backgroundColor]),
                    options: options,
                    context: CMarkContext()
                )
            }
        }
        // don't warm, sized when building IssueCommentTableModel
        return builders.map {
            StyledTextRenderer(
                string: $0.build(),
                contentSizeCategory: options.contentSizeCategory,
                inset: IssueCommentTableCollectionCell.inset,
                backgroundColor: backgroundColor
            )
        }
    }
}

private extension Array where Iterator.Element == TableRow {
    func build(options: CMarkOptions) -> [(cells: [StyledTextRenderer], fill: Bool)] {
        var rowIndex = 0
        return map {
            let fill = rowIndex % 2 == 1
            if case .row = $0 { rowIndex += 1}
            return ($0.build(options: options, greyBackground: fill), fill)
        }
    }
}

private extension Element {
    func model(_ options: CMarkOptions) -> ListDiffable? {
        switch self {
        case .text(let items):
            return StyledTextRenderer(
                string: items.build(StyledTextBuilder.markdownBase(), options: options, context: CMarkContext())
                    .build(renderMode: .preserve),
                contentSizeCategory: options.contentSizeCategory,
                inset: IssueCommentTextCell.inset,
                backgroundColor: .white
                ).warm(width: options.width)
        case .quote(let items, let level):
            let builder = StyledTextBuilder.markdownBase()
                .add(attributes: [.foregroundColor: Styles.Colors.Gray.medium.color])
            let string = StyledTextRenderer(
                string: items.build(builder, options: options, context: CMarkContext()).build(renderMode: .preserve),
                contentSizeCategory: options.contentSizeCategory,
                inset: IssueCommentQuoteCell.inset(quoteLevel: level),
                backgroundColor: .white
                ).warm(width: options.width)
            return IssueCommentQuoteModel(level: level, string: string)
        case .image(let title, let url):
            return CreateImageModel(href: url, title: title)
        case .html(let text):
            let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { return nil }
            let baseURL: URL?
            if let branch = options.branch {
                baseURL = URL(string: "https://github.com/\(options.owner)/\(options.repo)/raw/\(branch)/")
            } else {
                baseURL = nil
            }
            return IssueCommentHtmlModel(html: trimmed, baseURL: baseURL)
        case .hr:
            return IssueCommentHrModel()
        case .codeBlock(let text, let language):
            return CodeBlockElement(text: text, language: language)
        case .heading(let text, let level):
            let builder = StyledTextBuilder.markdownBase()
            let style: TextStyle
            switch level {
            case 1: style = Styles.Text.h1
            case 2: style = Styles.Text.h2
            case 3: style = Styles.Text.h3
            case 4: style = Styles.Text.h4
            case 5: style = Styles.Text.h5
            default: style = Styles.Text.h6.with(foreground: Styles.Colors.Gray.medium.color)
            }
            builder.add(style: style)
            return StyledTextRenderer(
                string: text.build(builder, options: options, context: CMarkContext()).build(renderMode: .preserve),
                contentSizeCategory: options.contentSizeCategory,
                inset: IssueCommentTextCell.inset,
                backgroundColor: .white
                ).warm(width: options.width)
        case .list(let items, let type):
            let builder = items.build(StyledTextBuilder.markdownBase(), options: options, type: type, level: 0)
            return StyledTextRenderer(
                string: builder.build(renderMode: .preserve),
                contentSizeCategory: options.contentSizeCategory,
                inset: IssueCommentTextCell.inset,
                backgroundColor: .white
                ).warm(width: options.width)
        case .table(let rows):
            var buckets = [TableBucket]()
            var rowHeights = [CGFloat]()

            let results = rows.build(options: options)
            results.forEach {
                fillBuckets(rows: $0.cells, buckets: &buckets, rowHeights: &rowHeights, fill: $0.fill)
            }

            return IssueCommentTableModel(buckets: buckets, rowHeights: rowHeights)
        }
    }
}

func MarkdownModels(
    _ markdown: String,
    owner: String,
    repo: String,
    width: CGFloat,
    viewerCanUpdate: Bool,
    contentSizeCategory: UIContentSizeCategory
    ) -> [ListDiffable] {
    let cleaned = markdown
        .replacingGithubEmojiRegex
        .strippingHTMLComments
        .removingHTMLEntities
        .trimmingCharacters(in: .whitespacesAndNewlines)
    guard let node = Node(markdown: cleaned) else { return [] }
    let options = CMarkOptions(
        owner: owner,
        repo: repo,
        branch: nil, // TODO pass in branch
        width: width,
        viewerCanUpdate: viewerCanUpdate,
        contentSizeCategory: contentSizeCategory
    )
    return node.flatElements.compactMap { $0.model(options) }
}

