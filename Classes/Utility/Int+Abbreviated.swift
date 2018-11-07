//
//  Int+Abbreviated.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/6/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension Int {

    var abbreviated: String {
        // less than 1000, no abbreviation
        if self < 1_000 {
            return "\(self)"
        }

        // less than 1 million, abbreviate to thousands
        if self < 1_000_000 {
            var n = Double(self)
            n = Double( floor(n/100)/10 )
            return "\(n.description)k"
        }

        // more than 1 million, abbreviate to millions
        var n = Double(self)
        n = Double( floor(n/100_000)/10 )
        return "\(n.description)m"
    }

}
