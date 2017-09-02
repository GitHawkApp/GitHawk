//
//  SearchResult.swift
//  Freetime
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

final class SearchResult: ListDiffable, RepositoryLoadable {
    
    let id: String
    let owner: String
    let name: String
    let description: NSAttributedStringSizing?
    let stars: Int
    let pushedAt: Date?
    let primaryLanguage: GithubLanguage?
    let hasIssuesEnabled: Bool
    
    init(repo: SearchReposQuery.Data.Search.Node.AsRepository, containerWidth: CGFloat) {
        self.id = repo.id
        self.name = repo.name
        self.owner = repo.owner.login
        self.stars = repo.stargazers.totalCount
        self.hasIssuesEnabled = repo.hasIssuesEnabled
        
        if let description = repo.description {
            let attributes = [
                NSFontAttributeName: Styles.Fonts.secondary,
                NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
            ]
            
            self.description = NSAttributedStringSizing(
                containerWidth: containerWidth,
                attributedText: NSAttributedString(string: description, attributes: attributes),
                inset: SearchResultCell.labelInset
            )
        } else {
            self.description = nil
        }
        
        if let pushedAt = repo.pushedAt {
            self.pushedAt = GithubAPIDateFormatter().date(from: pushedAt)
        } else {
            self.pushedAt = nil
        }
        
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
