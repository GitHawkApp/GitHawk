//
//  RepositoryReadmeModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class RepositoryReadmeModel: ListDiffable, ListSwiftDiffable {

    let models: [ListDiffable]

    init(models: [ListDiffable]) {
        self.models = models
    }

    // MARK: ListDiffable
    // TODO REMOVE

    func diffIdentifier() -> NSObjectProtocol {
        return "readme" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // for use w/ binding SC
        return true
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return "readme"
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
