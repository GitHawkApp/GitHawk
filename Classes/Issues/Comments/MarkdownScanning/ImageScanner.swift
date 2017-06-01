//
//  ImageScanner.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

private let imageRegex = try! NSRegularExpression(
    pattern: "!\\[.+]\\((.*?)\\)",
    options: [.useUnixLineSeparators]
)

let imageScanner =  MarkdownScanner { (body, width) in
    var results = [(NSRange, IGListDiffable)]()
    let matches = imageRegex.matches(in: body, options: [], range: body.nsrange)
    for match in matches {
        if let string = body.substring(with: match.rangeAt(1)), let url = URL(string: string) {
            results.append((match.range, IssueCommentImageModel(url: url)))
        }
    }
    return results
}
