//
//  IssueCommentUnsupportedModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentUnsupportedModel: IGListDiffable {

    let name: String
    let uuid = NSUUID()

    init(name: String) {
        self.name = name
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return uuid
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }

}
