//
//  CodeBlockScanner.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import UIKit

private func codeBlockString(
    _ body: String
    ) -> NSAttributedStringSizing {
    let attributes: [String: Any] = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
        NSFontAttributeName: Styles.Fonts.code
    ]
    let attributedText = NSAttributedString(
        string: body.trimmingCharacters(in: .whitespacesAndNewlines),
        attributes: attributes
    )
    var inset = IssueCommentCodeBlockCell.textViewInset
    inset.left += IssueCommentCodeBlockCell.scrollViewInset.left
    inset.right += IssueCommentCodeBlockCell.scrollViewInset.right
    return NSAttributedStringSizing(
        containerWidth: 0,
        attributedText: attributedText,
        inset: inset
    )
}

private let codeRegex = try! NSRegularExpression(
    pattern: "^```([a-zA-Z0-9-]+)?$(.*?)^```$",
    options: [.useUnixLineSeparators, .dotMatchesLineSeparators, .anchorsMatchLines]
)

let codeBlockScanner =  MarkdownScanner { (body, width) in
    var results = [(NSRange, IGListDiffable)]()
    let matches = codeRegex.matches(in: body, options: [], range: body.nsrange)
    for match in matches {
        let language = body.substring(with: match.rangeAt(1))
        if let code = body.substring(with: match.rangeAt(2)) {
            results.append((match.range, IssueCommentCodeBlockModel(code: codeBlockString(code), language: language)))
        }
    }
    return results
}
