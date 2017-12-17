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
    let color: UIColor

    init(label: String, imageName: String, color: UIColor) {
        self.label = label
        self.imageName = imageName
        self.color = color
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return label as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // keep it simple
        return true
    }

}
