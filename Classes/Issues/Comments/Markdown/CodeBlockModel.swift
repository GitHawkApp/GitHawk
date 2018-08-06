//
//  CodeBlockModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import StyledTextKit

func CodeBlockElement(
    text: String,
    language: String?,
    contentSizeCategory: UIContentSizeCategory
    ) -> IssueCommentCodeBlockModel {
    let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
    let attributedString: NSAttributedString

    let fixedLanguage = language?.isEmpty == true ? nil : language
    if let language = fixedLanguage,
        let highlighted = GithubHighlighting.highlight(trimmedText, as: language) {
        attributedString = highlighted
    } else {
        attributedString = NSAttributedString(
            string: trimmedText,
            attributes: [
                .foregroundColor: Styles.Colors.Gray.dark.color,
                .font: Styles.Text.code.font(contentSizeCategory:contentSizeCategory)
            ]
        )
    }

    var inset = IssueCommentCodeBlockCell.textViewInset
    inset.left += IssueCommentCodeBlockCell.scrollViewInset.left
    inset.right += IssueCommentCodeBlockCell.scrollViewInset.right

    let backgroundColor = Styles.Colors.Gray.lighter.color
    let builder = StyledTextBuilder(attributedText: attributedString)
        .add(attributes: [.backgroundColor: backgroundColor])
    let string = StyledTextRenderer(
        string: builder.build(),
        contentSizeCategory: contentSizeCategory,
        inset: inset,
        backgroundColor: backgroundColor
    ).warm(width: 0)
    return IssueCommentCodeBlockModel(
        code: string,
        language: fixedLanguage
    )
}
