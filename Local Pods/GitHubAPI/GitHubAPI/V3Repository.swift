//
//  V3Repository.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3Repository: Codable {

    public let description: String
    public let fork: Bool
    public let fullName: String // custom
    public let id: Int
    public let name: String
    public let owner: V3User
    public let isPrivate: Bool // custom

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
