//
//  IssueCommentBodyModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import CocoaMarkdown

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
        .trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) else { return nil }

    let data = between.data(using: .utf8)
    let document = CMDocument(data: data, options: [])

    let textAttributes = CMTextAttributes()
    textAttributes?.textAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
        NSFontAttributeName: Styles.Fonts.body,
    ]
    textAttributes?.linkAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.blue,
        NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue
    ]
    textAttributes?.inlineCodeAttributes = [
        NSForegroundColorAttributeName: Styles.Colors.Gray.dark,
        NSBackgroundColorAttributeName: Styles.Colors.Gray.lighter,
        NSFontAttributeName: Styles.Fonts.code
    ]

    let listStyle = NSMutableParagraphStyle()
    textAttributes?.orderedListAttributes = [
        NSParagraphStyleAttributeName: listStyle
    ]
    textAttributes?.unorderedListAttributes = [
        NSParagraphStyleAttributeName: listStyle
    ]

    let attributedString = document!.attributedString(with: textAttributes)!

    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
        inset: IssueCommentTextCell.inset
    )
}

private let imageRegex = try! NSRegularExpression(pattern: "!\\[.+]\\((.+)\\)", options: [.useUnixLineSeparators])

func imageURLMatches(body: String) -> [NSTextCheckingResult] {
    return imageRegex.matches(in: body, options: [], range: body.nsrange)
}

// http://nshipster.com/nsregularexpression/
extension String {
    /// An `NSRange` that represents the full range of the string.
    var nsrange: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }

    /// Returns a substring with the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func substring(with nsrange: NSRange) -> String? {
        guard let range = nsrange.toRange()
            else { return nil }
        let start = UTF16Index(range.lowerBound)
        let end = UTF16Index(range.upperBound)
        return String(utf16[start..<end])
    }

    /// Returns a range equivalent to the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func range(from nsrange: NSRange) -> Range<Index>? {
        guard let range = nsrange.toRange() else { return nil }
        let utf16Start = UTF16Index(range.lowerBound)
        let utf16End = UTF16Index(range.upperBound)

        guard let start = Index(utf16Start, within: self),
            let end = Index(utf16End, within: self)
            else { return nil }

        return start..<end
    }
}

func createCommentModels(body: String, width: CGFloat) -> [IGListDiffable] {

    var result = [IGListDiffable]()

    let matches = imageURLMatches(body: body)
    var location = 0

    for match in matches {
        if let sizing = bodyString(body: body, width: width, start: location, end: match.range.location) {
            result.append(sizing)
        }

        location = match.range.location + match.range.length

        if let string = body.substring(with: match.rangeAt(1)), let url = URL(string: string) {
            result.append(IssueCommentImageModel(url: url))
        }
    }

    let end = body.utf16.count
    if let remaining = bodyString(body: body, width: width, start: location, end: end) {
        result.append(remaining)
    }

    return result
}
