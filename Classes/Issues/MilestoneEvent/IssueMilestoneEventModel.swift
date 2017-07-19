//
//  IssueMilestoneEventModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMilestoneEventModel: ListDiffable {

    enum MilestoneType {
        case milestoned
        case demilestoned
    }

    let id: String
    let actor: String
    let milestone: String
    let date: Date
    let type: MilestoneType

    init(id: String, actor: String, milestone: String, date: Date, type: MilestoneType) {
        self.id = id
        self.actor = actor
        self.milestone = milestone
        self.date = date
        self.type = type
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
