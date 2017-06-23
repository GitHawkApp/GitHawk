//
//  IssueLabeledModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabeledModel: ListDiffable {

    enum EventType {
        case added
        case removed
    }

    let id: String
    let actor: String
    let title: String
    let color: String
    let date: Date
    let type: EventType

    init(
        id: String,
        actor: String,
        title: String,
        color: String,
        date: Date,
        type: EventType
        ) {
        self.id = id
        self.actor = actor
        self.title = title
        self.color = color
        self.date = date
        self.type = type
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // assume that if ids match then its the same object
        return true
    }

}
