//
//  GithubClient+Paging.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

private let linkRegex = try! NSRegularExpression(pattern: "rel=\\\"?([^\\\"]+)\\\"?", options: [])

// https://github.com/octokit/octokit.objc/blob/2290cdc66d4a58aef9970bb540d9bb84fb4245e6/OctoKit/OCTClient.m#L745-L775
func PagingData(link: String?) -> GithubClient.Page? {
    guard let link = link else { return nil }
    let links = link.components(separatedBy: ",")

    var whitespaceAndBrackets = CharacterSet.whitespaces
    whitespaceAndBrackets.insert(charactersIn: "<>")

    var next: Int? = nil
    var last: Int? = nil

    for l in links {
        guard let semicolonRange = l.range(of: ";") else { continue }
        let urlString = l[l.utf8.startIndex..<semicolonRange.lowerBound]
            .trimmingCharacters(in: whitespaceAndBrackets)
        guard let pageItem = urlString.valueForQuery(key: "page")
            else { continue }
        let page = (pageItem as NSString).integerValue

        guard let match = linkRegex.firstMatch(in: l, options: [], range: l.nsrange) else { continue }
        let substring = l.substring(with: match.range(at: 1))
        if substring == "next" {
            next = page
        } else if substring == "last" {
            last = page
        }
    }

    if let next = next, let last = last {
        return GithubClient.Page(next: next, last: last)
    }
    return nil
}
