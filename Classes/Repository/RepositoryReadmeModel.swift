//
//  RepositoryReadmeModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 9/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class RepositoryReadmeModel: ListDiffable {

    let models: [ListDiffable]

    init(models: [ListDiffable]) {
        self.models = models
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "readme" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // for use w/ binding SC
        return true
    }

}
