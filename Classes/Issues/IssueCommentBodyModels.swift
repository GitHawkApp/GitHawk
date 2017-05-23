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
    return NSAttributedStringSizing(
        containerWidth: CGFloat.greatestFiniteMagnitude,
        attributedText: attributedText
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
        NSForegroundColorAttributeName: Styles.Colors.blue,
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

private let imageRegex = try! NSRegularExpression(pattern: "!\\[.+]\\((.+)\\)", options: [.useUnixLineSeparators])
private let blockCodeRegex = try! NSRegularExpression(pattern: "(?s)```([a-zA-Z0-9-]+)?(.*?)```", options: [.useUnixLineSeparators])

func imageURLMatches(body: String) -> [NSTextCheckingResult] {
    return imageRegex.matches(in: body, options: [], range: body.nsrange)
}

struct BodyScanner {

    let regex: NSRegularExpression
    let handler: (String, CGFloat, NSTextCheckingResult) -> IGListDiffable?

}

let imageScanner = BodyScanner(
    regex: try! NSRegularExpression(pattern: "!\\[.+]\\((.+)\\)", options: [.useUnixLineSeparators]),
    handler: { (body, width, match) in
        if let string = body.substring(with: match.rangeAt(1)), let url = URL(string: string) {
            return IssueCommentImageModel(url: url)
        }
        return nil
}
)

let codeBlockScanner = BodyScanner(
    regex: try! NSRegularExpression(pattern: "```([a-zA-Z0-9-]+)?(.*?)```", options: [.useUnixLineSeparators, .dotMatchesLineSeparators]),
    handler: { (body, width, match) in
        let language = body.substring(with: match.rangeAt(1))
        if let code = body.substring(with: match.rangeAt(2)) {
            return IssueCommentCodeBlockModel(code: codeBlockString(code), language: language)
        }
        return nil
}
)

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

    let newlineCleanedBody = body.replacingOccurrences(of: "\r\n", with: "\n")

    var results = [IGListDiffable]()

    var matchPairs = [ (NSTextCheckingResult, BodyScanner) ]()

    for scanner in [imageScanner, codeBlockScanner] {
        let matches = scanner.regex.matches(in: newlineCleanedBody, options: [], range: newlineCleanedBody.nsrange)
        let pairs = matches.map { ($0, scanner) }
        matchPairs += pairs
    }

    matchPairs.sort { $0.0.range.location < $1.0.range.location }

    var location = 0

    for (match, scanner) in matchPairs {
        if let sizing = bodyString(body: newlineCleanedBody, width: width, start: location, end: match.range.location) {
            results.append(sizing)
        }

        location = match.range.location + match.range.length

        if let result = scanner.handler(newlineCleanedBody, width, match) {
            results.append(result)
        }
    }

    let end = newlineCleanedBody.utf16.count
    if let remaining = bodyString(body: newlineCleanedBody, width: width, start: location, end: end) {
        results.append(remaining)
    }
    
    return results
}
