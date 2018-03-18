//
//  MMElement+Attributes.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import MMMarkdown

func PushAttributes(
    element: MMElement,
    current: [NSAttributedStringKey: Any],
    listLevel: Int
    ) -> [NSAttributedStringKey: Any] {
    let currentFont: UIFont = current[.font] as? UIFont ?? Styles.Text.body.preferredFont

    // TODO: cleanup
    let paragraphStyleCopy: NSMutableParagraphStyle = paragraphStyle(for: current)

    var newAttributes: [NSAttributedStringKey: Any]
    switch element.type {
    case .strikethrough: newAttributes = [
        .strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
        .strikethroughColor: current[.foregroundColor]
            ?? Styles.Colors.Gray.dark.color
        ]
    case .strong: newAttributes = [
        .font: currentFont.addingTraits(traits: .traitBold)
        ]
    case .em: newAttributes = [
        .font: currentFont.addingTraits(traits: .traitItalic)
        ]
    case .codeSpan: newAttributes = [
            .font: Styles.Text.code.preferredFont,
            NSAttributedStringKey.backgroundColor: Styles.Colors.Gray.lighter.color,
            MarkdownAttribute.usernameDisabled: true,
            MarkdownAttribute.linkShorteningDisabled: true
        ]
        // Apply color Grey only if the link style was not applied on this element.
        if current[MarkdownAttribute.url] == nil {
            newAttributes[.foregroundColor] = Styles.Colors.Gray.dark.color
        }
    case .link, .shortenedLink:
        newAttributes = [
        .foregroundColor: Styles.Colors.Blue.medium.color,
        MarkdownAttribute.url: element.href ?? ""
        ]
    case .header:
        switch element.level {
        case 1: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Text.h1.size)
            ]
        case 2: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Text.h2.size)
            ]
        case 3: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Text.h3.size)
            ]
        case 4: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Text.h4.size)
            ]
        case 5: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Text.h5.size)
            ]
        default: newAttributes = [
            .foregroundColor: Styles.Colors.Gray.medium.color,
            .font: UIFont.boldSystemFont(ofSize: Styles.Text.h6.size)
            ]
        }
    case .bulletedList, .numberedList:
        let indent: CGFloat = (CGFloat(listLevel) - 1) * 18
        paragraphStyleCopy.firstLineHeadIndent = indent
        paragraphStyleCopy.firstLineHeadIndent = indent
        newAttributes = [.paragraphStyle: paragraphStyleCopy]
    case .listItem:
        // if after the first element, tighten list spacing
        if element.numberedListPosition > 1 || listLevel > 1 {
            paragraphStyleCopy.paragraphSpacingBefore = 2
        }
        newAttributes = [.paragraphStyle: paragraphStyleCopy]
    case .blockquote: newAttributes = [
        .foregroundColor: Styles.Colors.Gray.medium.color
        ]
    case .mailTo: newAttributes = [
        .foregroundColor: Styles.Colors.Blue.medium.color,
        MarkdownAttribute.email: element.href ?? ""
        ]
    case .username:
        if let username = element.username {
            newAttributes = [
                .font: currentFont.addingTraits(traits: .traitBold),
                MarkdownAttribute.username: username
            ]
        } else {
            newAttributes = [:]
        }
    case .shorthandIssues:
        if let repo = element.repository, let owner = element.owner {
            newAttributes = [
                .foregroundColor: Styles.Colors.Blue.medium.color,
                MarkdownAttribute.issue: IssueDetailsModel(
                    owner: owner,
                    repo: repo,
                    number: element.number
                )
            ]
        } else {
            newAttributes = [:]
        }
    default: newAttributes = [:]
    }
    var attributes = current
    for (k, v) in newAttributes {
        attributes[k] = v
    }
    return attributes
}

fileprivate func paragraphStyle(for current:  [NSAttributedStringKey: Any]) -> NSMutableParagraphStyle {
    guard let para = (current[.paragraphStyle] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle  else {
        return NSMutableParagraphStyle()
    }
    return para
}
