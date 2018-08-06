//
//  IssueLabelsModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabelsModel: ListDiffable {

    let status: IssueLabelStatusModel
    let locked: Bool
    let labels: [RepositoryLabel]

    init(
        status: IssueLabelStatusModel,
        locked: Bool,
        labels: [RepositoryLabel]
        ) {
        self.status = status
        self.locked = locked
        self.labels = labels
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // hardcoded b/c one per list
        return "labels" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
