//
//  User.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3User: Codable {

    enum UserType: String, Codable {
        case user = "User"
        case organization = "Organization"
    }

    let avatarUrl: URL
    let id: Int
    let login: String
    let siteAdmin: Bool
    let type: UserType

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id
        case login
        case siteAdmin = "site_admin"
        case type
    }

}
