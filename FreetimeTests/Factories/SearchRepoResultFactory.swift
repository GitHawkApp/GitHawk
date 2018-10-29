//
//  SearchRepoResultFactory.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

@testable import Freetime
enum SearchRepoResultFactory {
    static func create(
        id: String = String(),
        owner: String = String(),
        name: String = String(),
        description: String = String(),
        stars: Int = 0,
        hasIssuesEnabled: Bool = false,
        primaryLanguage: GithubLanguage? = nil,
        defaultBranch: String = String()
        ) -> SearchRepoResult {
        return SearchRepoResult(
            id: id,
            owner: owner,
            name: name,
            description: description,
            stars: stars,
            hasIssuesEnabled: hasIssuesEnabled,
            primaryLanguage: primaryLanguage,
            defaultBranch: defaultBranch)
    }
}
