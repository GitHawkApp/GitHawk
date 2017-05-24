//
//  DetailsScanner.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

private let detailsStart = try! NSRegularExpression(
    pattern: "<details>",
    options: [.useUnixLineSeparators, .dotMatchesLineSeparators]
)
private let detailsEnd = try! NSRegularExpression(
    pattern: "</details>",
    options: [.useUnixLineSeparators, .dotMatchesLineSeparators]
)
private let detailsSummary = try! NSRegularExpression(
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

let detailsScanner = MarkdownScanner { (body, width) in
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
