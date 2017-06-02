//
//  IssueLabelModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueLabelModel: IGListDiffable {

    let color: String
    let name: String

    init(color: String, name: String) {
        self.color = color
        self.name = name
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueLabelModel else { return false }
        return color == object.color
    }

}
