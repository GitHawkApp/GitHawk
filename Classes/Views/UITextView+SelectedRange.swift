//
//  UITextView+SelectedRange.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/31/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UITextView {

    private func oneCharRange(pos: UITextPosition?) -> UITextRange? {
        guard let pos = pos,
            let position = self.position(from: pos, offset: 1) else { return nil }
        return self.textRange(from: pos, to: position)
    }

    private func text(atPosition position: UITextPosition?) -> String? {
        guard let position = position,
            let range = oneCharRange(pos: position) else { return nil }
        return text(in: range)
    }

    func startOfLine(forRange range: UITextRange) -> UITextPosition {

        func previousPosition(pos: UITextPosition?) -> UITextPosition? {
            guard let pos = pos else { return nil }
            return self.position(from: pos, offset: -1)
        }

        var position: UITextPosition? =  previousPosition(pos: range.start)
        while let text = text(atPosition: position), text != "\n" { // check if it's the EoL
            position = previousPosition(pos: position) // move back 1 char
        }

        if let position = position, // we have a position
            let pos = self.position(from: position, offset: 1) { // need to advance by one...
            return pos
        }

        return beginningOfDocument // not found? Go to the beginning
    }

    func replace(left: String, right: String?, atLineStart: Bool) {
        guard let range = selectedTextRange, // seems to be always set
            let text = text(in: range) // no selection = ""
        else { return }

        let replacementText = "\(left)\(text)\(right ?? "")"

        var insertionRange = range
        if atLineStart {
            let startLinePosition = startOfLine(forRange: range)
            insertionRange = textRange(from: startLinePosition, to: startLinePosition) ?? range
        }

        replace(insertionRange, withText: replacementText)
        if range.start == range.end, // single cursor (no selection)
            let position = position(from: range.start, // advance by the inserted before
                offset: left.lengthOfBytes(using: .utf8)) {
            selectedTextRange = textRange(from: position, to: position) // single cursor
        }
    }

}
