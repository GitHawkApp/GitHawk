//
//  QuoteScanner.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import CocoaMarkdown
import IGListKit

private func quoteString(_ body: String, width: CGFloat) -> NSAttributedStringSizing? {
    guard let textAttributes = CMTextAttributes() else { return nil }

    textAttributes.textAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.light,
        NSFontAttributeName: Styles.Fonts.body,
    ]
    textAttributes.linkAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Blue.light,
    ]
    textAttributes.inlineCodeAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.light,
        NSBackgroundColorAttributeName: Styles.Colors.Gray.lighter,
        NSFontAttributeName: Styles.Fonts.code,
    ]

    return CreateMarkdownString(
        body: body,
        width: width,
        attributes: textAttributes,
        inset: IssueCommentQuoteCell.inset(quoteLevel: 0)
    )
}

private let quoteRegex = try! NSRegularExpression(
    pattern: "^(>.*(\n|$))+",
    options: [.useUnixLineSeparators, .anchorsMatchLines]
)

let quoteScanner = MarkdownScanner { (body, width) in
    var results = [(NSRange, IGListDiffable)]()
    let matches = quoteRegex.matches(in: body, options: [], range: body.nsrange)
    for match in matches {
        if let substr = body.substring(with: match.rangeAt(0)),
        let quote = quoteString(substr, width: width) {
            results.append((match.range, IssueCommentQuoteModel(level: 0, quote: quote)))
        }
    }
    return results
}
