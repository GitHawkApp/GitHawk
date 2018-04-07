//
//  CodeBlockModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

func CodeBlockElement(text: String, language: String?) -> IssueCommentCodeBlockModel {
    let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
    let attributedString: NSAttributedString
    if let language = language, !language.isEmpty,
        let highlighted = GithubHighlighting.highlight(trimmedText, as: language) {
        attributedString = highlighted
    } else {
        attributedString = NSAttributedString(
            string: trimmedText,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.dark.color,
                .font: Styles.Text.code.preferredFont
            ]
        )
    }

    var inset = IssueCommentCodeBlockCell.textViewInset
    inset.left += IssueCommentCodeBlockCell.scrollViewInset.left
    inset.right += IssueCommentCodeBlockCell.scrollViewInset.right

    // TODO use builder later
    //            let builder = StyledTextBuilder.markdownBase()
    //                .add(attributedText: highlighted)

    let stringSizing = NSAttributedStringSizing(
        containerWidth: 0,
        attributedText: attributedString,
        inset: inset,
        backgroundColor: Styles.Colors.Gray.lighter.color
    )
    return IssueCommentCodeBlockModel(
        code: stringSizing,
        language: language
    )
}
