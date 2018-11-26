//
//  RepoBranchesViewModel.swift
//  Freetime
//
//  Created by B_Litwin on 9/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import IGListKit

struct RepositoryBranchViewModel: ListSwiftDiffable {
    let branch: String
    let selected: Bool

    var identifier: String {
        return branch
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? RepositoryBranchViewModel else { return false }
        return value.branch == branch
            && value.selected == selected
    }
}
