//
//  File+ListDiffable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension File: ListDiffable, ListSwiftDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return (filename + sha) as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        // assume that if the sha is the same, its the same patch
        return true
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return filename + sha
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
