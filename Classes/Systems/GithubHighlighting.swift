//
//  GithubHighlighting.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Highlightr

enum GithubHighlighting {

    private static var shared: Highlightr? = {
        let h = Highlightr()
        h?.setTheme(to: "github", fontSize: Styles.Text.code.preferredFont.pointSize)
        return h
    }()

    static func highlight(_ code: String, as language: String) -> NSAttributedString? {
        // Highlightr will return nil if given an empty language string
        let fixedLanguage = language.isEmpty ? nil : language
        return shared?.highlight(code, as: fixedLanguage, fastRender: true)
    }
    
    static func highlight(_ code: String) -> NSAttributedString? {
        return shared?.highlight(code)
    }
}
