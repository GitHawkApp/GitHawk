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
    let currentFont: UIFont = current[.font] as? UIFont ?? Styles.Fonts.body

    // TODO: cleanup
    let paragraphStyleCopy: NSMutableParagraphStyle
    if let para = (current[.paragraphStyle] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle {
        paragraphStyleCopy = para
    } else {
        paragraphStyleCopy = NSMutableParagraphStyle()
    }

    var newAttributes: [NSAttributedStringKey: Any]
    switch element.type {
    case .strikethrough: newAttributes = [
        .strikethroughStyle: NSUnderlineStyle.styleSingle.rawValue,
        .strikethroughColor: current[.foregroundColor]
            ?? Styles.Colors.Gray.dark.color,
        ]
    case .strong: newAttributes = [
        .font: currentFont.addingTraits(traits: .traitBold),
        ]
    case .em: newAttributes = [
        .font: currentFont.addingTraits(traits: .traitItalic),
        ]
    case .codeSpan: newAttributes = [
        .font: Styles.Fonts.code,
        NSAttributedStringKey.backgroundColor: Styles.Colors.Gray.lighter.color,
        .foregroundColor: Styles.Colors.Gray.dark.color,
        MarkdownAttribute.usernameDisabled: true,
        ]
    case .link: newAttributes = [
        .foregroundColor: Styles.Colors.Blue.medium.color,
        MarkdownAttribute.url: element.href ?? "",
        ]
    case .header:
        switch element.level {
        case 1: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h1),
            ]
        case 2: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h2),
            ]
        case 3: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h3),
            ]
        case 4: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h4),
            ]
        case 5: newAttributes = [
            .font: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h5),
            ]
        default: newAttributes = [
            .foregroundColor: Styles.Colors.Gray.medium.color,
            .font: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h6),
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
        .foregroundColor: Styles.Colors.Gray.medium.color,
        ]
    case .mailTo: newAttributes = [
        .foregroundColor: Styles.Colors.Blue.medium.color,
        MarkdownAttribute.email: element.href ?? ""
        ]
    default: newAttributes = [:]
    }
    var attributes = current
    for (k, v) in newAttributes {
        attributes[k] = v
    }
    return attributes
}
