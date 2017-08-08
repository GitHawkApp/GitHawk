//
//  MMElement+Attributes.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import MMMarkdown

let MarkdownURLName = "MarkdownURLName"

func PushAttributes(element: MMElement, current: [String: Any], listLevel: Int) -> [String: Any] {
    let currentFont: UIFont = current[NSFontAttributeName] as? UIFont ?? Styles.Fonts.body

    let paragraphStyleCopy: NSMutableParagraphStyle
    if let para = (current[NSParagraphStyleAttributeName] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle {
        paragraphStyleCopy = para
    } else {
        paragraphStyleCopy = NSMutableParagraphStyle()
    }

    var newAttributes: [String: Any]
    switch element.type {
    case .strikethrough: newAttributes = [
        NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
        NSStrikethroughColorAttributeName: current[NSForegroundColorAttributeName] ?? Styles.Colors.Gray.dark.color,
        ]
    case .strong: newAttributes = [
        NSFontAttributeName: currentFont.addingTraits(traits: .traitBold),
        ]
    case .em: newAttributes = [
        NSFontAttributeName: currentFont.addingTraits(traits: .traitItalic),
        ]
    case .codeSpan: newAttributes = [
        NSFontAttributeName: Styles.Fonts.code,
        NSBackgroundColorAttributeName: Styles.Colors.Gray.lighter.color,
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
        UsernameDisabledAttributeName: true,
        ]
    case .link: newAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Blue.medium.color,
        MarkdownURLName: element.href ?? "",
        ]
    case .header:
        switch element.level {
        case 1: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h1),
            ]
        case 2: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h2),
            ]
        case 3: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h3),
            ]
        case 4: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h4),
            ]
        case 5: newAttributes = [
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h5),
            ]
        default: newAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.medium.color,
            NSFontAttributeName: UIFont.boldSystemFont(ofSize: Styles.Sizes.Text.h6),
            ]
        }
    case .bulletedList, .numberedList:
        let indent: CGFloat = (CGFloat(listLevel) - 1) * 18
        paragraphStyleCopy.firstLineHeadIndent = indent
        paragraphStyleCopy.firstLineHeadIndent = indent
        newAttributes = [NSParagraphStyleAttributeName: paragraphStyleCopy]
    case .listItem:
        // if after the first element, tighten list spacing
        if element.numberedListPosition > 1 || listLevel > 1 {
            paragraphStyleCopy.paragraphSpacingBefore = 2
        }
        newAttributes = [NSParagraphStyleAttributeName: paragraphStyleCopy]
    case .blockquote: newAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.medium.color
        ]
    default: newAttributes = [:]
    }
    var attributes = current
    for (k, v) in newAttributes {
        attributes[k] = v
    }
    return attributes
}
