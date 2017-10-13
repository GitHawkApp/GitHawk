//
//  SearchRepoResult.swift
//  GitHawk
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

struct GithubLanguage {
    let name: String
    let color: UIColor?
}

class SearchRepoResult: ListDiffable {
    
    let id: String
    let owner: String
    let name: String
    let description: String
    let stars: Int
    let hasIssuesEnabled: Bool
    let primaryLanguage: GithubLanguage?
    
    init(
        id: String,
        owner: String,
        name: String,
        description: String,
        stars: Int,
        hasIssuesEnabled: Bool,
        primaryLanguage: GithubLanguage?
        ) {
        self.id = id
        self.owner = owner
        self.name = name
        self.description = description
        self.stars = stars
        self.hasIssuesEnabled = hasIssuesEnabled
        self.primaryLanguage = primaryLanguage
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SearchRepoResult else { return false }
        return id == object.id
            && name == object.name
    }
}
