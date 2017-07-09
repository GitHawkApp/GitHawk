//
//  String+HashDisplay.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension String {

    var hashDisplay: String {
        // trim to first <7 characters
        return substring(with: NSRange(location: 0, length: min(nsrange.length, 7))) ?? self
    }

}
