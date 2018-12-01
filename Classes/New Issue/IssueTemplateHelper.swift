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

class IssueTemplateHelper {

    static func getNameAndDescription(fromTemplatefile file: String) -> (name: String?, about: String?) {
        let names = file.matches(regex: String.getRegexForLine(after: "name"))
        let abouts = file.matches(regex: String.getRegexForLine(after: "about"))
        let name = names.first?.trimmingCharacters(in: .whitespaces)
        let about = abouts.first?.trimmingCharacters(in: .whitespaces)
        return (name, about)
    }
    
}
