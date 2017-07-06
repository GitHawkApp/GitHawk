//
//  IssueReviewDetailsModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReviewDetailsModel: ListDiffable {

    enum State: Int {
        case commented
        case requestedChanges
        case approved
    }

    let actor: String
    let state: State
    let date: Date

    init(actor: String, state: State, date: Date) {
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
