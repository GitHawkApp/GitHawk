//
//  IssueStatusModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueStatusModel: ListDiffable {

    let status: IssueStatus
    let pullRequest: Bool

    init(status: IssueStatus, pullRequest: Bool) {
        self.status = status
        self.pullRequest = pullRequest
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "status" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueStatusModel else { return false }
        return status == object.status && pullRequest == object.pullRequest
    }

}
