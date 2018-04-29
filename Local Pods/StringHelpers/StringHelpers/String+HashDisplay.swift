//
//  String+HashDisplay.swift
//  StringHelpers
//
//  Created by Ryan Nystrom on 4/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public extension String {

    var hashDisplay: String {
        // trim to first <7 characters
        return substring(with: NSRange(location: 0, length: min(nsrange.length, 7))) ?? self
    }

}
