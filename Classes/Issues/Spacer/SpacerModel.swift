//
//  SpacerModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/26/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class SpacerModel: NSObject, ListDiffable {

    private let _diffIdentifier: String

    init(position: Int) {
        _diffIdentifier = "vertical-spacer-\(position)"
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        return object is SpacerModel
    }

}
