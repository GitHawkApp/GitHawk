//
//  RepositoryDetails.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct RepositoryDetails: Codable, Equatable {
    let owner: String
    let name: String
    let hasIssuesEnabled: Bool
}

func == (lhs: RepositoryDetails, rhs: RepositoryDetails) -> Bool {
    return lhs.owner == rhs.owner &&
        lhs.name == rhs.name &&
        lhs.hasIssuesEnabled == rhs.hasIssuesEnabled
}
