//
//  IssueMergeButtonModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMergeButtonModel: ListDiffable {

    let enabled: Bool
    let type: IssueMergeType

    init(enabled: Bool, type: IssueMergeType) {
        self.enabled = enabled
        self.type = type
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // only one
        return "merge-button" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueMergeButtonModel else { return false }
        return enabled == object.enabled
        && type == object.type
    }
}
