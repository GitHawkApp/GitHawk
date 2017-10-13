//
//  IssueReferencedModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedCommitModel: ListDiffable {

    let id: String
    let owner: String
    let repo: String
    let hash: String
    let actor: String
    let date: Date

    init(
        id: String,
        owner: String,
        repo: String,
        hash: String,
        actor: String,
        date: Date
        ) {
        self.id = id
        self.owner = owner
        self.repo = repo
        self.hash = hash
        self.actor = actor
        self.date = date
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
