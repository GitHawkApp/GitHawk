//
//  SegmentedControlModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class SegmentedControlModel {

    let items: [String]
    fileprivate let _diffIdentifier: String

    init(items: [String]) {
        self.items = items
        _diffIdentifier = items.reduce("") { return $0 + $1 }
    }

}

extension SegmentedControlModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        // has to match based on the identifier, which is items folded
        return true
    }

}
