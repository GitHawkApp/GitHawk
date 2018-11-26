//
//  RepositoryDetails+ListSwiftDiffable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension RepositoryDetails: ListSwiftDiffable {

    var identifier: String {
        return "\(owner).\(name)"
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? RepositoryDetails else { return false }
        return defaultBranch == value.defaultBranch
        && hasIssuesEnabled == value.hasIssuesEnabled
    }

}
