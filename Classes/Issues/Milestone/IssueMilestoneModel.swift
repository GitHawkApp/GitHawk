//
//  IssueMilestoneModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 8/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueMilestoneModel: ListDiffable {

    let number: Int
    let title: String
    let completed: Int
    let total: Int

    init(number: Int, title: String, completed: Int, total: Int) {
        self.number = number
        self.title = title
        self.completed = completed
        self.total = total
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        // only only ever be one
        return "milestone" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? IssueMilestoneModel else { return false }
        return number == object.number
            && completed == object.completed
            && total == object.total
            && title == object.title
    }
    
}
