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
    let state: MergeableState
    let contexts: [IssueMergeContextModel]

    init(
        id: String,
        state: MergeableState,
        contexts: [IssueMergeContextModel]
        ) {
        self.id = id
        self.state = state
        self.contexts = contexts
    }

    // MARK: IssueMergeModel

    func diffIdentifier() -> NSObjectProtocol {
        return "merge-model\(id)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueMergeModel else { return false }
        return state == object.state
        // taking a shortcut instead of O(n) equality check. id should be enough
        && contexts.count == object.contexts.count
    }

}
