//
//  IssueStatusModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueStatusModel: IGListDiffable {

    let closed: Bool
    let pullRequest: Bool

    init(closed: Bool, pullRequest: Bool) {
        self.closed = closed
        self.pullRequest = pullRequest
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "status" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueStatusModel else { return false }
        return closed == object.closed && pullRequest == object.pullRequest
    }

}
