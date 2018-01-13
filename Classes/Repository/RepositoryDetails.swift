//
//  RepositoryDetails.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct RepositoryDetails: Codable {
    let owner: String
    let name: String
    let defaultBranch: String
    let hasIssuesEnabled: Bool
}

extension RepositoryDetails: Equatable {
    static func == (lhs: RepositoryDetails, rhs: RepositoryDetails) -> Bool {
        return lhs.owner == rhs.owner &&
            lhs.name == rhs.name &&
            lhs.defaultBranch == rhs.defaultBranch &&
            lhs.hasIssuesEnabled == rhs.hasIssuesEnabled
    }
}
