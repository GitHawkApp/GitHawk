//
//  IssueManagingActionModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueManagingActionModel: ListDiffable {

    let label: String
    let imageName: String

    init(label: String, imageName: String) {
        self.label = label
        self.imageName = imageName
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return label as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueManagingActionModel else { return false }
        return imageName == object.imageName
    }

}
