//
//  MMElement+CodeBlock.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import MMMarkdown

func CreateCodeBlock(element: MMElement, markdown: String) -> IssueCommentCodeBlockModel {
    // create the text from all 1d "none" child elements
    // code blocks should not have any other child element type aside from "entity", which is skipped
    let text = element.children.reduce("") {
        guard $1.type == .none || $1.type == .entity else { return $0 }
        return $0 + substringOrNewline(text: markdown, range: $1.range)
        }.trimmingCharacters(in: .whitespacesAndNewlines)

    var inset = IssueCommentCodeBlockCell.textViewInset
    inset.left += IssueCommentCodeBlockCell.scrollViewInset.left
    inset.right += IssueCommentCodeBlockCell.scrollViewInset.right

    let attributes: [String: Any] = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color,
        NSFontAttributeName: Styles.Fonts.code
    ]

    let stringSizing = NSAttributedStringSizing(
        containerWidth: 0,
        attributedText: NSAttributedString(string: text, attributes: attributes),
        inset: inset,
        backgroundColor: Styles.Colors.Gray.lighter.color
    )
    return IssueCommentCodeBlockModel(
        code: stringSizing,
        language: element.language
    )
}
