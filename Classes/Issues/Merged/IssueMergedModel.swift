//
//  IssueMergedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/29/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMergedModel: ListDiffable {

    let date: Date
    let commitHash: String
    let actor: String

    init(date: Date, commitHash: String, actor: String) {
        self.date = date
        self.commitHash = commitHash
        self.actor = actor
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return commitHash as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
