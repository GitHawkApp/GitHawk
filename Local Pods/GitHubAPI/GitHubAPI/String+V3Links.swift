//
//  String+V3Links.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

private let linkRegex = try! NSRegularExpression(pattern: "rel=\\\"?([^\\\"]+)\\\"?", options: [])

internal extension String {

    func valueForQuery(key: String) -> String? {
        guard let items = URLComponents(string: self)?.queryItems else { return nil }
        for item in items where item.name == key {
            return item.value
        }
        return nil
    }

    var httpNextPageNumber: Int? {
        let links = components(separatedBy: ",") as [NSString]

        var whitespaceAndBrackets = CharacterSet.whitespaces
        whitespaceAndBrackets.insert(charactersIn: "<>")

        for l in links {
            let semicolonRange = l.range(of: ";")

            guard semicolonRange.location < NSNotFound else { continue }

            let urlString = l.substring(to: semicolonRange.location)
                .trimmingCharacters(in: whitespaceAndBrackets)
            guard let pageItem = urlString.valueForQuery(key: "page")
                else { continue }
            let page = (pageItem as NSString).integerValue

            guard let match = linkRegex.firstMatch(
                in: l as String,
                options: [],
                range: NSRange(location: 0, length: l.length)
                ) else { continue }
            let substring = l.substring(with: match.range(at: 1))
            if substring == "next" {
                return page
            }
        }

        return nil
    }

}
