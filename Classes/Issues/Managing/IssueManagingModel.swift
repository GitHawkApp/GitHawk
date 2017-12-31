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

    enum ManagingPosition: Int {
        case top
        case bottom
    }

    let objectId: String
    let pullRequest: Bool
    let position: ManagingPosition

    init(objectId: String, pullRequest: Bool, position: ManagingPosition) {
        self.objectId = objectId
        self.pullRequest = pullRequest
        self.position = position
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // should only ever be one
        return "managing_model\(position)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueManagingModel else { return false }
        return pullRequest == object.pullRequest
        && objectId == object.objectId
    }

}
