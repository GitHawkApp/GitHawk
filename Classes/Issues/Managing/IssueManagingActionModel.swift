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

    let key: String
    let label: String
    let imageName: String
    let color: UIColor

    init(key: String, label: String, imageName: String, color: UIColor) {
        self.key = key
        self.label = label
        self.imageName = imageName
        self.color = color
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return key as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueManagingActionModel else { return false }
        return object.label == label
        && object.imageName == imageName
        // skip color, for some reason its a pricy comparison
    }

}
