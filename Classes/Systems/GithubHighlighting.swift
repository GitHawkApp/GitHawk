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
        h?.setTheme(to: "github", fontSize: Styles.Text.code.size)
        return h
    }()

    static func highlight(_ code: String, as language: String) -> NSAttributedString? {
        return shared?.highlight(code, as: language, fastRender: true)
    }
    
    static func highlight(_ code: String) -> NSAttributedString? {
        return shared?.highlight(code)
    }
}
