//
//  IssueMergeContextModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMergeContextModel: ListDiffable {

    let id: String
    let context: String
    let state: StatusState
    let login: String
    let avatarURL: URL
    let description: String

    init(
        id: String,
        context: String,
        state: StatusState,
        login: String,
        avatarURL: URL,
        description: String
        ) {
        self.id = id
        self.context = context
        self.state = state
        self.login = login
        self.avatarURL = avatarURL
        self.description = description
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueMergeContextModel else { return false }
        return context == object.context
        && state == object.state
        && login == object.login
        && avatarURL == object.avatarURL
        && description == object.description
    }

}
