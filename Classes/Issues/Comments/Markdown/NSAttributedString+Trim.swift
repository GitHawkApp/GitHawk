//
//  NSAttributedString+Trim.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

// https://stackoverflow.com/a/38738940/940936
extension NSAttributedString {

    public func attributedStringByTrimmingCharacterSet(charSet: CharacterSet) -> NSAttributedString {
        let modifiedString = NSMutableAttributedString(attributedString: self)
        modifiedString.trimCharactersInSet(charSet: charSet)
        return NSAttributedString(attributedString: modifiedString)
    }

}

extension NSMutableAttributedString {

    public func removeAll() {
        deleteCharacters(in: string.nsrange)
    }

    public func trimCharactersInSet(charSet: CharacterSet) {
        var range = (string as NSString).rangeOfCharacter(from: charSet)

        // Trim leading characters from character set.
        while range.length != 0 && range.location == 0 {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: charSet)
        }

        // Trim trailing characters from character set.
        range = (string as NSString).rangeOfCharacter(from: charSet, options: .backwards)
        while range.length != 0 && NSMaxRange(range) == length {
            replaceCharacters(in: range, with: "")
            range = (string as NSString).rangeOfCharacter(from: charSet, options: .backwards)
        }
    }

}
