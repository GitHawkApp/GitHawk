//
//  V3MarkRepositoryNotificationsRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3MarkRepositoryNotificationsRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode205>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "notifications"]
    }
    public var method: HTTPMethod { return .put }

    public let owner: String
    public let repo: String

    public init(owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
    }
}
