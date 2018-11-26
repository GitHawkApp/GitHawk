//
//  String+CustomBuilding.swift
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

private protocol CustomHandlingMatcher {
    var greaterThanMatches: Int { get }
    func leftLocation(result: NSTextCheckingResult) -> Int
    func handle(
        text: String,
        result: NSTextCheckingResult,
        owner: String,
        repo: String,
        builder: StyledTextBuilder
    )
}

private struct ShortlinkMatcher: CustomHandlingMatcher {
    var greaterThanMatches: Int { return 4 }
    func leftLocation(result: NSTextCheckingResult) -> Int {
        // if match is proceeded by optional spaces, include that
        return result.range(at: 1).location != NSNotFound
            ? result.range(at: 1).right
            : result.range.location
    }
    func handle(
        text: String,
        result: NSTextCheckingResult,
        owner: String,
        repo: String,
        builder: StyledTextBuilder
        ) {
        let number = text.substring(with: result.range(at: 5)) ?? "0"
        let foundOwner = text.substring(with: result.range(at: 3))
        let foundRepo = text.substring(with: result.range(at: 4))

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

        //if match's trailing character is not a number, include that
        if let right = text.substring(with: NSRange(location: result.range.right - 1, length: 1)) {
            if Int(right) == nil {
                builder.add(text: right)
            }
        }
    }
}

private struct SpecialEmojiMatcher: CustomHandlingMatcher {
    var greaterThanMatches: Int { return 1 }
    func leftLocation(result: NSTextCheckingResult) -> Int {
        return result.range.location
    }
    func handle(
        text: String,
        result: NSTextCheckingResult,
        owner: String,
        repo: String,
        builder: StyledTextBuilder
        ) {
        guard let emojiString = text.substring(with: result.range),
            let emoji = SpecialGitHubEmoji(
                rawValue: emojiString.trimmingCharacters(in: CharacterSet(charactersIn: ":"))
            ),
            let image = emoji.image
            else { return }
        builder.add(image: image)
    }
}

private struct CustomHandlingMatch {
    let result: NSTextCheckingResult
    let handler: CustomHandlingMatcher
}

private let shortlinkRegex = try! NSRegularExpression(pattern: "(^|\\s|[^a-zA-Z0-9/])(([\\w|-]+)/([\\w|-]+))?#([0-9]+)(?![a-zA-Z0-9])", options: [])

extension String {

    func detectAndHandleCustomRegex(owner: String, repo: String, builder: StyledTextBuilder) {
        let nsrange = self.nsrange

        let shortlinkMatches = shortlinkRegex.matches(in: self, options: [], range: nsrange).map {
            CustomHandlingMatch(result: $0, handler: ShortlinkMatcher())
        }
        let specialEmojiMatches = SpecialGitHubEmoji.regex.matches(in: self, options: [], range: nsrange).map {
            CustomHandlingMatch(result: $0, handler: SpecialEmojiMatcher())
        }

        let matches = (shortlinkMatches + specialEmojiMatches).sorted { (left, right) -> Bool in
            left.result.range.location < right.result.range.location
        }

        guard matches.count > 0 else {
            builder.add(text: self)
            return
        }

        var currentRight = 0
        for match in matches {
            guard match.result.numberOfRanges > match.handler.greaterThanMatches,
                match.result.range.location >= currentRight
                else { continue }

            // if match is proceeded by optional spaces, include that
            let leftLength = match.handler.leftLocation(result: match.result)
            if let left = substring(with: NSRange(location: currentRight, length: leftLength - currentRight)) {
                builder.add(text: left)
            }

            match.handler.handle(text: self, result: match.result, owner: owner, repo: repo, builder: builder)
            currentRight = match.result.range.right
        }

        // add remaining rightmost text
        if let right = substring(with: NSRange(location: currentRight, length: utf16.count - currentRight)) {
            builder.add(text: right)
        }
    }

}
