//
//  String+WordAtRange.swift
//  Alamofire
//
//  Created by Ryan Nystrom on 12/27/17.
//

import Foundation

internal extension String {

    func wordParts(_ range: Range<String.Index>) -> (left: String.SubSequence, right: String.SubSequence)? {
        let whitespace = NSCharacterSet.whitespacesAndNewlines
        let leftView = self[..<range.upperBound]
        let leftIndex = leftView.rangeOfCharacter(from: whitespace, options: .backwards)?.upperBound
            ?? leftView.startIndex

        let rightView = self[range.upperBound...]
        let rightIndex = rightView.rangeOfCharacter(from: whitespace)?.lowerBound
            ?? endIndex

        return (leftView[leftIndex...], rightView[..<rightIndex])
    }

    func word(at nsrange: NSRange) -> (word: String, range: Range<String.Index>)? {
        guard !isEmpty,
            let range = Range(nsrange, in: self),
            let parts = self.wordParts(range)
            else { return nil }

        // if the left-next character is whitespace, the "right word part" is the full word
        // short circuit with the right word part + its range
        if let characterBeforeRange = index(range.lowerBound, offsetBy: -1, limitedBy: startIndex),
            let character = self[characterBeforeRange].unicodeScalars.first,
            NSCharacterSet.whitespaces.contains(character) {
            let right = parts.right
            return (String(right), right.startIndex ..< right.endIndex)
        }

        let joinedWord = String(parts.left + parts.right)
        guard !joinedWord.isEmpty else { return nil }

        return (joinedWord, parts.left.startIndex ..< parts.right.endIndex)
    }

}
