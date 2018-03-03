//
//  V3Repository.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Repository: Codable {

    let description: String
    let fork: Bool
    let fullName: String // custom
    let id: Int
    let name: String
    let owner: V3User
    let isPrivate: Bool // custom

    enum CodingKeys: String, CodingKey {
        case description
        case fork
        case fullName = "full_name"
        case id
        case name
        case owner
        case isPrivate = "private"
    }

}
