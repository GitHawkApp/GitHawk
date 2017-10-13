//
//  IssueRequestModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueRequestModel: ListDiffable {

    enum Event {
        case assigned
        case unassigned
        case reviewRequested
        case reviewRequestRemoved
    }

    let id: String
    let actor: String
    let user: String
    let date: Date
    let event: Event

    init(id: String, actor: String, user: String, date: Date, event: Event) {
        self.id = id
        self.actor = actor
        self.user = user
        self.date = date
        self.event = event
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
