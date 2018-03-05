//
//  V3CreateIssueRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3CreateIssueNumber: Codable {
    public let number: Int
}

public struct V3CreateIssueRequest: V3Request {
    public typealias ResponseType = V3DataResponse<V3CreateIssueNumber>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "issues"]
    }
    public var method: HTTPMethod { return .post }
    public var parameters: [String : Any]? {
        return [
            "title": title,
            "body": body
        ]
    }

    public let owner: String
    public let repo: String
    public let title: String
    public let body: String

    public init(owner: String, repo: String, title: String, body: String) {
        self.owner = owner
        self.repo = repo
        self.title = title
        self.body = body
    }
}
