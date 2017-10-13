//
//  IssueReferencedModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReferencedModel: ListDiffable {

    enum State: Int {
        case open
        case closed
        case merged
    }

    let id: String
    let owner: String
    let repo: String
    let number: Int
    let pullRequest: Bool
    let state: State
    let date: Date
    let title: String

    init(
        id: String,
        owner: String,
        repo: String,
        number: Int,
        pullRequest: Bool,
        state: State,
        date: Date,
        title: String
        ) {
        self.id = id
        self.owner = owner
        self.repo = repo
        self.number = number
        self.pullRequest = pullRequest
        self.state = state
        self.date = date
        self.title = title
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
