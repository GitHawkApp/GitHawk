//
//  SegmentedControlModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class SegmentedControlModel: ListDiffable {

    let items: [String]
    private let _diffIdentifier: String
    var selectedIndex: Int = 0

    init(items: [String]) {
        self.items = items
        _diffIdentifier = items.reduce("") { return $0 + $1 }
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return _diffIdentifier as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? SegmentedControlModel else { return false }
        return selectedIndex == object.selectedIndex
    }

}
