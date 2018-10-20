//
//  PathHistoryViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/20/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

struct PathHistoryViewModel {

    let owner: String
    let repo: String
    let client: GithubClient
    let branch: String
    let path: FilePath?

}
