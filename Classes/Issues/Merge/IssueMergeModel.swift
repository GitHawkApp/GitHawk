//
//  IssueMergeModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMergeModel: ListDiffable {

    let id: String
    let state: MergeStateStatus
    let contexts: [IssueMergeContextModel]
    let availableTypes: [IssueMergeType]

    init(
        id: String,
        state: MergeStateStatus,
        contexts: [IssueMergeContextModel],
        availableTypes: [IssueMergeType]
        ) {
        self.id = id
        self.state = state
        self.contexts = contexts
        self.availableTypes = availableTypes
    }

    // MARK: IssueMergeModel

    func diffIdentifier() -> NSObjectProtocol {
        return "merge-model\(id)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // used in binding SC
        return true
    }

}
