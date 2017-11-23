//
//  CommitDetails.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class CommitDetails {

    let owner: String
    let repo: String
    let hash: String

    init(owner: String, repo: String, hash: String) {
        self.owner = owner
        self.repo = repo
        self.hash = hash
    }

}
