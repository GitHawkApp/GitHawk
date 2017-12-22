//
//  UITextView+Prefixes.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

internal extension UITextView {

    func find(prefixes: Set<String>) -> (prefix: String, word: String, range: NSRange)? {
        guard prefixes.count > 0,
            let result = wordAtCaret,
            result.word.length > 0
            else { return nil }
        for prefix in prefixes {
            if result.word.hasPrefix(prefix) {
                return (prefix, result.word as String, result.range)
            }
        }
        return nil
    }

    var wordAtCaret: (word: NSString, range: NSRange)? {
        guard let caretRange = self.caretRange else { return nil }
        guard !text.isEmpty else { return nil }

        let nsstringText = text as NSString

        let left = nsstringText.substring(to: caretRange.location)
        guard let leftWordPart = left.components(separatedBy: .whitespacesAndNewlines).last as NSString?
            else { return nil }

        let right = nsstringText.substring(from: caretRange.location)
        guard let rightWordPart = right.components(separatedBy: .whitespacesAndNewlines).first as NSString?
            else { return nil }

        if caretRange.location > 0 {
            let characterBeforeCursor = nsstringText.substring(
                with: NSRange(location: caretRange.location - 1, length: 1)
                ) as NSString
            let whitespaceRange = characterBeforeCursor.rangeOfCharacter(from: .whitespaces)
            if whitespaceRange.length == 1 {
                return (rightWordPart, NSRange(location: caretRange.location, length: rightWordPart.length))
            }
        }

        let joinedWord = (leftWordPart as String) + (rightWordPart as String)hi
        let newline = "\n"
        if joinedWord.contains(newline) {
            guard let word = joinedWord.components(separatedBy: newline).last
                else { return nil }
            return (word as NSString, nsstringText.range(of: joinedWord))
        } else {
            let range = NSRange(
                location: caretRange.location - leftWordPart.length,
                length: leftWordPart.length + rightWordPart.length
            )
            return (joinedWord as NSString, range)
        }
    }

    var caretRange: NSRange? {
        guard let selectedRange = self.selectedTextRange else { return nil }
        return NSRange(
            location: offset(from: beginningOfDocument, to: selectedRange.start),
            length: offset(from: selectedRange.start, to: selectedRange.end)
        )
    }

}

