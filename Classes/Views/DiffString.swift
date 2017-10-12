//
//  DiffString.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Highlightr

func CreateColorCodedString(code: String, includeDiff: Bool=false) -> NSAttributedString {
    guard let highlightr = Highlightr() else { return NSAttributedString(string: code) }

    highlightr.setTheme(to: "github")
    let colorCodedString = highlightr.highlight(code, as: nil) ?? NSAttributedString(string: code)
    let lines = code.components(separatedBy: CharacterSet.newlines)

    if includeDiff {
        let attributedText = NSMutableAttributedString(attributedString: colorCodedString)

        for line in lines {
            if line.hasPrefix("+") {
                let attributes = [NSAttributedStringKey.backgroundColor: Styles.Colors.Green.light.color]
                attributedText.addAttributes(for: line, attributes: attributes, mode: .all)
            } else if line.hasPrefix("-") {
                let attributes = [NSAttributedStringKey.backgroundColor: Styles.Colors.Red.light.color]
                attributedText.addAttributes(for: line, attributes: attributes, mode: .all)
            }
        }

        return attributedText
    }

    return colorCodedString
}

func CreateDiffString(code: String, limit: Bool = false) -> NSAttributedString {
    let split = code.components(separatedBy: CharacterSet.newlines)
    let count = split.count

    let lines: [String]
    if limit {
        let cutLines = min(count, 4)
        lines = Array(split[(count-cutLines)..<count])
    } else {
        lines = split
    }

    let attributedString = NSMutableAttributedString()

    for line in lines {
        var attributes = [
            NSAttributedStringKey.font: Styles.Fonts.code,
            NSAttributedStringKey.foregroundColor: Styles.Colors.Gray.dark.color
        ]

        if line.hasPrefix("+") {
            attributes[NSAttributedStringKey.backgroundColor] = Styles.Colors.Green.light.color
        } else if line.hasPrefix("-") {
            attributes[NSAttributedStringKey.backgroundColor] = Styles.Colors.Red.light.color
        }

        let newlinedLine = line != lines.last ? line + "\n" : line
        attributedString.append(NSAttributedString(string: newlinedLine, attributes: attributes))
    }

    return attributedString
}
