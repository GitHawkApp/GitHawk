//
//  IssueCommentUnsupportedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentUnsupportedModel: ListDiffable {

    let name: String
    let uuid = NSUUID()

    init(name: String) {
        self.name = name
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return uuid
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
