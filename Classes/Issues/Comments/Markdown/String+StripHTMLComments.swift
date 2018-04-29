//
//  String+StripHTMLComments.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import StringHelpers

private let regex = try! NSRegularExpression(pattern: "<!--((.|\n|\r)*?)-->", options: [])
extension String {
    var strippingHTMLComments: String {
        let matches = regex.matches(in: self, options: [], range: nsrange)
        guard matches.count > 0 else { return self }
        var string = self
        for match in matches.reversed() {
            guard let range = range(from: match.range) else { continue }
            string.replaceSubrange(range, with: "")
        }
        return string
    }
}
