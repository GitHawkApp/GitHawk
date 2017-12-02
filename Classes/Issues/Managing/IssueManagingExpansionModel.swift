//
//  IssueManagingExpansionModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueManagingExpansionModel: ListDiffable {

    let expanded: Bool

    init(expanded: Bool) {
        self.expanded = expanded
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "managing-model" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueManagingExpansionModel else { return false }
        return expanded == object.expanded
    }

}
