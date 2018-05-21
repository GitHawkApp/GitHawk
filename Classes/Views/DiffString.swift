//
//  DiffString.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import StyledText

func CreateDiffString(code: String, limit: Bool = false) -> StyledTextString {
    let split = code.components(separatedBy: CharacterSet.newlines)
    let count = split.count

    let lines: [String]
    if limit {
        let cutLines = min(count, 4)
        lines = Array(split[(count-cutLines)..<count])
    } else {
        lines = split
    }

    let builder = StyledTextBuilder(styledText: StyledText(style: Styles.Text.code))
        .add(attributes: [.foregroundColor: Styles.Colors.Gray.dark.color])

    for line in lines {
        defer { builder.restore() }
        builder.save()

        if line.hasPrefix("+") {
            builder.add(attributes: [.backgroundColor: Styles.Colors.Green.light.color])
        } else if line.hasPrefix("-") {
            builder.add(attributes: [.backgroundColor: Styles.Colors.Red.light.color])
        }

        builder.add(text: line != lines.last ? line + "\n" : line)
    }

    return builder.build()
}
