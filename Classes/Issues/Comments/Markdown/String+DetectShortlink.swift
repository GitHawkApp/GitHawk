//
//  String+DetectShortlink.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

private let issueShorthandRegex = try! NSRegularExpression(pattern: "(^|\\s)((\\w+)/(\\w+))?#([0-9]+)", options: [])
extension String {
    var detectShortlink: (owner: String?, repo: String?, number: Int)? {
        guard let match = issueShorthandRegex.firstMatch(in: self, options: [], range: nsrange),
            match.numberOfRanges > 4
            else { return nil }
        guard let numberSubstring = substring(with: match.range(at: 5)) else { return nil }
        return (
            substring(with: match.range(at: 3)),
            substring(with: match.range(at: 4)),
            (numberSubstring as NSString).integerValue
        )
    }
}
