//
//  V3RepositoryNotificationResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3RepositoryNotificationRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Notification]>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "notifications"]
    }
    public var parameters: [String : Any]? {
        return [
            "all": all.description,
            "participating": "false",
            "per_page": "50"
        ]
    }

    public let all: Bool
    public let owner: String
    public let repo: String

    public init(all: Bool = true, owner: String, repo: String) {
        self.all = all
        self.owner = owner
        self.repo = repo
    }
}
