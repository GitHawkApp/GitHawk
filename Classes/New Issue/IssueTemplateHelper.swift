//
//  IssueTemplates.swift
//  Freetime
//
//  Created by Ehud Adler on 11/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI
import GitHubSession
import Squawk

struct IssueTemplate {
    let title: String
    let template: String
}

final class IssueTemplateHelper {

    static func getNameAndDescription(fromTemplatefile file: String) -> (name: String?, about: String?) {
        let names = file.matches(regex: String.getRegexForLine(after: "name"))
        let abouts = file.matches(regex: String.getRegexForLine(after: "about"))
        let name = names.first?.trimmingCharacters(in: .whitespaces)
        let about = abouts.first?.trimmingCharacters(in: .whitespaces)
        return (name, about)
    }

    static func cleanText(file: String) -> String {

        var cleanedFile = ""
        // Remove all template detail text
        // -----
        // name:
        // about:
        // -----
        if let textToClean = file.matches(regex: "([-]{3,})[^[-]{3,}]*([-]{3,})").first {
            if let range = file.range(of: textToClean) {
                cleanedFile = file.replacingOccurrences(
                    of: textToClean,
                    with: "",
                    options: .literal,
                    range: range
                )
            }
            cleanedFile = cleanedFile.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        return cleanedFile
    }
}
