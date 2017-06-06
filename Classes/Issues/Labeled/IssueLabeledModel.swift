//
//  IssueLabeledModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/6/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabeledModel: IGListDiffable {

    enum EventType {
        case added
        case removed
    }

    let id: String
    let actor: String
    let title: String
    let color: String
    let type: EventType

    init(id: String, actor: String, title: String, color: String, type: EventType) {
        self.id = id
        self.actor = actor
        self.title = title
        self.color = color
        self.type = type
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueLabeledModel else { return false }
        return actor == object.actor
        && title == object.title
        && color == object.color
        // skipping type in favor of the event id distinguishing between the two
    }

}
