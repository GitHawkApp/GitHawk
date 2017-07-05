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

extension MMElement {

    func attributes(
        currentAttributes: [String: Any],
        listLevel: Int
        ) -> [String: Any] {
        let currentFont: UIFont = currentAttributes[NSFontAttributeName] as? UIFont ?? Styles.Fonts.body

        let currentPara: NSMutableParagraphStyle
        if let para = (currentAttributes[NSParagraphStyleAttributeName] as? NSParagraphStyle)?.mutableCopy() as? NSMutableParagraphStyle {
            currentPara = para
        } else {
            currentPara = NSMutableParagraphStyle()
        }

        var newAttributes: [String: Any]
        switch type {
        case .strikethrough: newAttributes = [
            NSStrikethroughStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
            NSStrikethroughColorAttributeName: currentAttributes[NSForegroundColorAttributeName] ?? Styles.Colors.Gray.dark.color,
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
            MarkdownURLName: href ?? "",
            ]
        case .header:
            switch level {
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
            currentPara.firstLineHeadIndent = indent
            currentPara.firstLineHeadIndent = indent
            newAttributes = [NSParagraphStyleAttributeName: currentPara]
        case .blockquote: newAttributes = [
            NSForegroundColorAttributeName: Styles.Colors.Gray.medium.color
            ]
        default: newAttributes = [:]
        }
        var attributes = currentAttributes
        for (k, v) in newAttributes {
            attributes[k] = v
        }
        return attributes
        
    }
    
}
