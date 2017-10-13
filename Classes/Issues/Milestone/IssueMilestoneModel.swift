//
//  IssueMilestoneModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMilestoneModel: ListDiffable {

    let number: Int
    let title: String

    init(number: Int, title: String) {
        self.number = number
        self.title = title
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // only only ever be one
        return "milestone" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? IssueMilestoneModel else { return false }
        return number == object.number
            && title == object.title
    }
    
}
