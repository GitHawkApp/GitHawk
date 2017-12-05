//
//  IssueFileChangesModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueFileChangesModel: ListDiffable {

    let changes: FileChanges

    init(changes: FileChanges) {
        self.changes = changes
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // should only have one in a list
        return "file_changes" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueFileChangesModel else { return false }
        return changes == object.changes
    }

}
