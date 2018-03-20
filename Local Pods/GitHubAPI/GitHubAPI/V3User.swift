//
//  User.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3User: Codable {

    public enum UserType: String, Codable {
        case user = "User"
        case organization = "Organization"
    }

    public let avatarUrl: URL
    public let id: Int
    public let login: String
    public let siteAdmin: Bool
    public let type: UserType

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case id
        case login
        case siteAdmin = "site_admin"
        case type
    }

}
