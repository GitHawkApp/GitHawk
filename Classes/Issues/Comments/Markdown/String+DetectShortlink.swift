//
//  String+DetectShortlink.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import StyledTextKit
import StringHelpers

extension NSRange {
    var right: Int {
        return location + length
    }
}

private let regex = try! NSRegularExpression(pattern: "(^|\\s)((\\w+)/(\\w+))?(#([0-9]+)|\\(#([0-9]+)\\))($|\\s)", options: [])
extension String {
    func detectAndHandleShortlink(owner: String, repo: String, builder: StyledTextBuilder) {
        let matches = regex.matches(in: self, options: [], range: nsrange)
        guard matches.count > 0 else {
            builder.add(text: self)
            return
        }

        var currentRight = 0
        for match in matches {
            guard match.numberOfRanges > 4,
                let number = substring(with: match.range(at: 5))
                else { continue }

            // if match is proceeded by optional spaces, include that
            let leftLength = match.range(at: 1).location != NSNotFound
                ? match.range(at: 1).right
                : match.range.location
            if let left = substring(with: NSRange(location: currentRight, length: leftLength - currentRight)) {
                builder.add(text: left)
            }

            let foundOwner = substring(with: match.range(at: 3))
            let foundRepo = substring(with: match.range(at: 4))

            let linkText: String
            if let foundOwner = foundOwner, let foundRepo = foundRepo {
                linkText = "\(foundOwner)/\(foundRepo)#\(number)"
            } else {
                linkText = "#\(number)"
            }

            builder.save()
                .add(text: linkText, attributes: [
                    .foregroundColor: Styles.Colors.Blue.medium.color,
                    MarkdownAttribute.issue: IssueDetailsModel(
                        owner: foundOwner ?? owner,
                        repo: foundRepo ?? repo,
                        number: (number as NSString).integerValue
                    )
                    ])
                .restore()

            currentRight = match.range.right
        }

        // add remaining rightmost text
        if let right = substring(with: NSRange(location: currentRight, length: utf16.count - currentRight)) {
            builder.add(text: right)
        }
    }
}

