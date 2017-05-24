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
        attributedText: attributedText,
        inset: IssueCommentCodeBlockCell.inset
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

let detailsStart = try! NSRegularExpression(
    pattern: "<details>",
    options: [.useUnixLineSeparators, .dotMatchesLineSeparators]
)
let detailsEnd = try! NSRegularExpression(
    pattern: "</details>",
    options: [.useUnixLineSeparators, .dotMatchesLineSeparators]
)
let detailsSummary = try! NSRegularExpression(
    pattern: "<summary>(.+)</summary>",
    options: []
)
func detailsRanges(_ body: String) -> [NSRange] {
    var matches = [ (range: NSRange, start: Bool) ]()

    matches += detailsStart
        .matches(in: body, options: [], range: body.nsrange)
        .map { (range: $0.range, start: true) }

    matches += detailsEnd
        .matches(in: body, options: [], range: body.nsrange)
        .map { (range: $0.range, start: false) }

    matches.sort { $0.range.location < $1.range.location }

    var count = 0
    var start = 0

    var ranges = [NSRange]()

    for match in matches {
        if match.start {
            count += 1
        } else {
            count -= 1
        }

        if count == 1, match.start {
            start = match.range.location
        } else if count == 0 {
            ranges.append(NSRange(location: start, length: match.range.location + match.range.length - start))
        }
    }

    return ranges
}

struct BodyScanner {

    let handler: (String, CGFloat) -> [(NSRange, IGListDiffable)]

}

let detailsScanner = BodyScanner { (body, width) in
    var results = [(NSRange, IGListDiffable)]()
    let ranges = detailsRanges(body)
    for range in ranges {
        if let match = detailsSummary.firstMatch(in: body, options: [], range: range),
            let summary = body.substring(with: match.rangeAt(1)) {
            results.append((range, IssueCommentSummaryModel(summary: summary)))
        }
    }
    return results
}

let imageRegex = try! NSRegularExpression(pattern: "!\\[.+]\\((.+)\\)", options: [.useUnixLineSeparators])
let imageScanner =  BodyScanner { (body, width) in
        var results = [(NSRange, IGListDiffable)]()
        let matches = imageRegex.matches(in: body, options: [], range: body.nsrange)
        for match in matches {
            if let string = body.substring(with: match.rangeAt(1)), let url = URL(string: string) {
                results.append((match.range, IssueCommentImageModel(url: url)))
            }
        }
        return results
        }

let codeRegex = try! NSRegularExpression(pattern: "```([a-zA-Z0-9-]+)?(.*?)```", options: [.useUnixLineSeparators, .dotMatchesLineSeparators])
let codeBlockScanner =  BodyScanner { (body, width) in
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

    var scannerResults = [(NSRange, IGListDiffable)]()
    for scanner in [imageScanner, codeBlockScanner, detailsScanner] {
        scannerResults += scanner.handler(newlineCleanedBody, width)
    }
    scannerResults.sort { $0.0.location < $1.0.location }

    var results = [IGListDiffable]()
    var location = 0
    for (range, model) in scannerResults {
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
