//
//  V3PullRequestCommentsRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3PullRequestCommentsRequest: V3Request {
    public typealias ResponseType = JSONResponse<[[String: Any]]>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "pulls", "\(number)", "comments"]
    }

    public let owner: String
    public let repo: String
    public let number: Int

    public init(owner: String, repo: String, number: Int) {
        self.owner = owner
        self.repo = repo
        self.number = number
    }
}
