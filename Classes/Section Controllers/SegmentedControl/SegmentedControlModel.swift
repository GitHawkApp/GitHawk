//
//  SegmentedControlModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class SegmentedControlModel: IGListDiffable {

    let items: [String]
    fileprivate let _diffIdentifier: String
    var selectedIndex: Int = 0

    init(items: [String]) {
        self.items = items
        _diffIdentifier = items.reduce("") { return $0 + $1 }
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SegmentedControlModel else { return false }
        return selectedIndex == object.selectedIndex
    }

}
