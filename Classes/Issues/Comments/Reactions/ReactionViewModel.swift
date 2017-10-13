//
//  ReactionViewModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ReactionViewModel {

    let content: ReactionContent
    let count: Int
    let viewerDidReact: Bool
    let users: [String]

}
