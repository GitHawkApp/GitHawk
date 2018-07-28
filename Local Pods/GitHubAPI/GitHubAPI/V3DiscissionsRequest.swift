//
//  V3DiscissionsRequest.swift
//  GitHubAPI
//
//  Created by Bas Broek on 28/07/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3DiscussionsRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Discussion]>
    public var pathComponents: [String] {
        return ["teams", teamID, "discussion"]
    }

    public var parameters: [String : Any]? {
        return ["per_page": 50, "page": page, "direction": direction.rawValue]
    }

    public var headers: [String : String]? {
        return ["Accept": "application/vnd.github.echo-preview+json"]
    }

    public enum Direction: String {
        case ascending = "asc"
        case descending = "desc"
    }

    public let teamID: String
    public let page: Int
    public let direction: Direction

    /// - parameter direction: Defaults to `.descending`, as per
    /// [GitHub's documentation](https://developer.github.com/v3/teams/discussions/#parameters).
    public init(teamID: Int, direction: Direction = .descending, page: Int) {
        self.teamID = String(teamID)
        self.direction = direction
        self.page = page
    }
}
