//
//  IssueClosedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueClosedModel: IGListDiffable {

    let id: String
    let actor: String
    let date: Date
    let closed: Bool
    let pullRequest: Bool

    init(id: String, actor: String, date: Date, closed: Bool, pullRequest: Bool) {
        self.id = id
        self.actor = actor
        self.date = date
        self.closed = closed
        self.pullRequest = pullRequest
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        // if the ids match, it should be the same object
        return true
    }

}
