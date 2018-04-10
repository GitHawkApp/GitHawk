//
//  String+Shortlink.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

private let regex = try! NSRegularExpression(pattern: "https?:\\/\\/.*github.com\\/(\\w*)\\/([^/]*?)\\/issues\\/([0-9]+)", options: [])
extension String {
    var shortlinkInfo: (owner: String, repo: String, number: Int)? {
        guard let match = regex.firstMatch(in: self, options: [], range: nsrange),
            match.numberOfRanges > 3,
            let ownerSubstring = substring(with: match.range(at: 1)),
            let repoSubstring = substring(with: match.range(at: 2)),
            let numberSubstring = substring(with: match.range(at: 3))
            else { return nil }
        return (ownerSubstring, repoSubstring, (numberSubstring as NSString).integerValue)
    }
}
