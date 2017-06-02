//
//  CreateCommentModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import CocoaMarkdown
import IGListKit

private func markdownString(
    body: String,
    width: CGFloat,
    attributes: CMTextAttributes,
    inset: UIEdgeInsets
    ) -> NSAttributedStringSizing? {
    let data = body.data(using: .utf8)
    guard let document = CMDocument(data: data, options: [.hardBreaks]),
        let attributedString = document.attributedString(with: attributes)
        else { return nil }

    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
        inset: inset
    )
}

private func bodyString(
    body: String,
    width: CGFloat,
    start: Int,
    end: Int
    ) -> NSAttributedStringSizing? {
    guard
        end > 0,
        end - start > 0,
        let between = body
            .substring(with: NSRange(location: start, length: end - start))?
            .trimmingCharacters(in: .whitespacesAndNewlines),
        let textAttributes = CMTextAttributes()
        else { return nil }

    textAttributes.textAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
        NSFontAttributeName: Styles.Fonts.body,
    ]
    textAttributes.linkAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Blue.medium,
        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
    ]
    textAttributes.inlineCodeAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
        NSBackgroundColorAttributeName: Styles.Colors.Gray.lighter,
        NSFontAttributeName: Styles.Fonts.code,
    ]
    textAttributes.orderedListAttributes = [
        NSParagraphStyleAttributeName: NSParagraphStyle(),
    ]
    textAttributes.unorderedListAttributes = [
        NSParagraphStyleAttributeName: NSParagraphStyle(),
    ]

    return markdownString(
        body: between,
        width: width,
        attributes: textAttributes,
        inset: IssueCommentTextCell.inset
    )
}

func createCommentModels(body: String, width: CGFloat) -> [IGListDiffable] {

    let newlineCleanedBody = body.replacingOccurrences(of: "\r\n", with: "\n")

    var scannerResults = [(NSRange, IGListDiffable)]()
    for scanner in [imageScanner, codeBlockScanner, detailsScanner] {
        scannerResults += scanner.handler(newlineCleanedBody, width)
    }
    scannerResults.sort { $0.0.location < $1.0.location }

    var results = [IGListDiffable]()
    var location = 0
    for (range, model) in scannerResults {
        guard range.location >= location else { continue }

        if let sizing = bodyString(body: newlineCleanedBody, width: width, start: location, end: range.location) {
            results.append(sizing)
        }

        location = range.location + range.length

        results.append(model)
    }

    let end = newlineCleanedBody.utf16.count
    if let remaining = bodyString(body: newlineCleanedBody, width: width, start: location, end: end) {
        results.append(remaining)
    }
    
    return results
}
