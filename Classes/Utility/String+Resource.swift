//
//  String+Resource.swift
//  Freetime
//
//  Created by Ivan Magda on 01/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

// MARK: String+Resource

extension String {

    private static let nonPlainTextTypes = ["pdf"]

    /// A Boolean value indicating whether a string is non-plain text type.
    ///
    /// Non-plain text types: **pdf**.
    var isNonPlain: Bool {
        for type in String.nonPlainTextTypes {
            if self.hasSuffix(type) {
                return true
            }
        }

        return false
    }

}
