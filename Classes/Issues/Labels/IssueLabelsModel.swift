//
//  IssueLabelsModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabelsModel: ListDiffable {

    let viewerCanUpdate: Bool
    let labels: [RepositoryLabel]

    init(viewerCanUpdate: Bool, labels: [RepositoryLabel]) {
        self.viewerCanUpdate = viewerCanUpdate
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
