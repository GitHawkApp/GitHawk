//
//  IssueStatusEventModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueStatusEventModel: ListDiffable {

    let id: String
    let actor: String
    let date: Date
    let status: IssueStatusEvent
    let pullRequest: Bool

    init(id: String, actor: String, date: Date, status: IssueStatusEvent, pullRequest: Bool) {
        self.id = id
        self.actor = actor
        self.date = date
        self.status = status
        self.pullRequest = pullRequest
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // if the ids match, it should be the same object
        return true
    }

}
