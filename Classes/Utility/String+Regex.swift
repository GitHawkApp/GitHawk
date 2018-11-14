//
//  String+Regex.swift
//  Freetime
//
//  Created by Ehud Adler on 11/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import UIKit


extension String {
    func matches(regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let str = self as NSString
            let results = regex.matches(
                in: self,
                range: NSRange(
                    location: 0,
                    length: str.length
                )
            )
            return results.map { str.substring(with: $0.range) }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }

    static func getRegexForLine(after text: String) -> String {
        return "(?<=\(text):).*"
    }
}

