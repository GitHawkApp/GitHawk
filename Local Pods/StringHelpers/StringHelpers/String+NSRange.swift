//
//  String+NSRange.swift
//  StringHelpers
//
//  Created by Ryan Nystrom on 4/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

// http://nshipster.com/nsregularexpression/
public extension String {

    /// An `NSRange` that represents the full range of the string.
    var nsrange: NSRange {
        return NSRange(location: 0, length: utf16.count)
    }

    /// Returns a substring with the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func substring(with nsrange: NSRange) -> String? {
        guard let range = Range(nsrange, in: self) else { return nil }
        return String(self[range])
    }

    /// Returns a range equivalent to the given `NSRange`,
    /// or `nil` if the range can't be converted.
    func range(from nsrange: NSRange) -> Range<Index>? {
        return Range(nsrange, in: self)
    }

}
