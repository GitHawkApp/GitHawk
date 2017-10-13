//
//  IssuePreviewModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 8/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssuePreviewModel: NSObject, ListDiffable {

    let models: [ListDiffable]

    init(models: [ListDiffable]) {
        self.models = models
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
