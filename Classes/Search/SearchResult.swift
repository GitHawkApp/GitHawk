//
//  SearchResult.swift
//  Freetime
//
//  Created by Sherlock, James on 28/07/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

class SearchResult: ListDiffable {
    
    let id: String
    let name: String
    let description: String?
    let stars: Int
    let primaryLanguage: GithubLanguage?
    
    init(repo: SearchReposQuery.Data.Search.Node.AsRepository) {
        self.id = repo.id
        self.name = repo.nameWithOwner
        self.description = repo.description
        self.stars = repo.stargazers.totalCount
        
        if let language = repo.primaryLanguage {
            self.primaryLanguage = GithubLanguage(name: language.name, color: language.color?.color)
        } else {
            self.primaryLanguage = nil
        }
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SearchResult else { return false }
        return id == object.id && name == object.name
    }
}

struct GithubLanguage {
    let name: String
    let color: UIColor?
}
