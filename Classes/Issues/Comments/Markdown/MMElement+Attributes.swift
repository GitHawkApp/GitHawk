//
//  MMElement+Attributes.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import MMMarkdown
import StyledText

func PushAttributes(
    element: MMElement,
    builder: StyledTextBuilder,
    listLevel: Int
    ) {
    //    let currentFont: UIFont = current[.font] as? UIFont ?? Styles.Text.body.preferredFont
    let attributes = builder.tipAttributes ?? [:]

    // TODO: cleanup
    let paragraphStyleCopy: NSMutableParagraphStyle = paragraphStyle(for: attributes)

    switch element.type {
    case .strikethrough:
        builder.add(attributes: [
            .strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
            .strikethroughColor: attributes[.foregroundColor] ?? Styles.Colors.Gray.dark.color
            ])
    case .strong:
        builder.add(traits: .traitBold)
    case .em:
        builder.add(traits: .traitItalic)
    case .codeSpan:
        // Apply color Grey only if the link style was not applied on this element.
        let color: UIColor? = attributes[MarkdownAttribute.url] == nil ? Styles.Colors.Gray.dark.color : nil
        builder.add(attributes: [
            .font: Styles.Text.code.preferredFont,
            .backgroundColor: Styles.Colors.Gray.lighter.color,
            MarkdownAttribute.usernameDisabled: true,
            MarkdownAttribute.linkShorteningDisabled: true,
            .foregroundColor: color as Any
            ])
    case .link, .shortenedLink:
        builder.add(attributes: [
            .foregroundColor: Styles.Colors.Blue.medium.color,
            MarkdownAttribute.url: element.href ?? ""
            ])
    case .header:
        switch element.level {
        case 1: builder.add(style: Styles.Text.h1)
        case 2: builder.add(style: Styles.Text.h2)
        case 3: builder.add(style: Styles.Text.h3)
        case 4: builder.add(style: Styles.Text.h4)
        case 5: builder.add(style: Styles.Text.h5)
        default: builder.add(style: Styles.Text.h6.with(foreground: Styles.Colors.Gray.medium.color))
        }
    case .bulletedList, .numberedList:
        paragraphStyleCopy.firstLineHeadIndent = (CGFloat(listLevel) - 1) * 18
        builder.add(attributes: [.paragraphStyle: paragraphStyleCopy])
    case .listItem:
        // if after the first element, tighten list spacing
        if element.numberedListPosition > 1 || listLevel > 1 {
            paragraphStyleCopy.paragraphSpacingBefore = 2
        }
        builder.add(attributes: [.paragraphStyle: paragraphStyleCopy])
    case .blockquote:
        builder.add(attributes: [.foregroundColor: Styles.Colors.Gray.medium.color])
    case .mailTo:
        builder.add(attributes: [
            .foregroundColor: Styles.Colors.Blue.medium.color,
            MarkdownAttribute.email: element.href ?? ""
            ])
    case .username:
        if let username = element.username {
            builder.add(traits: .traitBold, attributes: [MarkdownAttribute.username: username])
        }
    case .shorthandIssues:
        if let repo = element.repository, let owner = element.owner {
            builder.add(attributes: [
                .foregroundColor: Styles.Colors.Blue.medium.color,
                MarkdownAttribute.issue: IssueDetailsModel(
                    owner: owner,
                    repo: repo,
                    number: element.number
                )
                ])
        }
    default: break
    }
}

fileprivate func paragraphStyle(for current:  [NSAttributedStringKey: Any]) -> NSMutableParagraphStyle {
    guard let para = (current[.paragraphStyle] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle  else {
        return NSMutableParagraphStyle()
    }
    return para
}

