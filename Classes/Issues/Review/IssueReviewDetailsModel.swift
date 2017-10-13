//
//  IssueReviewDetailsModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReviewDetailsModel: ListDiffable {

    let actor: String
    let state: PullRequestReviewState
    let date: Date

    init(actor: String, state: PullRequestReviewState, date: Date) {
        self.actor = actor
        self.state = state
        self.date = date
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // assuming only one per list
        return "review-details" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}
