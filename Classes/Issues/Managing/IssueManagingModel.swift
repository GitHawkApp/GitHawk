//
//  IssueManagingModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueManagingModel: ListDiffable {

    enum Role: Int {
        case author
        case collaborator
    }

    let objectId: String
    let pullRequest: Bool
    let role: Role

    init(objectId: String, pullRequest: Bool, role: Role) {
        self.objectId = objectId
        self.pullRequest = pullRequest
        self.role = role
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // should only ever be one
        return "managing_model" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueManagingModel else { return false }
        return pullRequest == object.pullRequest
        && objectId == object.objectId
        && role == object.role
    }

}
