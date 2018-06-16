//
//  MilestoneViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

struct MilestoneViewModel: ListSwiftDiffable {
    let title: String
    let due: String
    let selected: Bool

    // MARK: ListSwiftDiffable

    var identifier: String {
        return title
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? MilestoneViewModel else { return false }
        return due == value.due
        && selected == value.selected
    }

}
