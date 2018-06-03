//
//  MilestoneViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

struct MilestoneViewModel: ListSwiftIdentifiable, ListSwiftEquatable {
    let title: String
    let due: String
    let selected: Bool

    // MARK: ListSwiftIdentifiable

    var identifier: String {
        return title
    }

    // MARK: ListSwiftEquatable

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? MilestoneViewModel else { return false }
        return due == value.due
        && selected == value.selected
    }

}
