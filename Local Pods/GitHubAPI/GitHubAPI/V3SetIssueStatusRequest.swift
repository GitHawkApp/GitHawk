//
//  V3SetIssueStatusRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3SetIssueStatusRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode200>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "issues", "\(number)"]
    }
    public var method: HTTPMethod { return .patch }
    public var parameters: [String : Any]? {
        return ["state": state]
    }

    public let owner: String
    public let repo: String
    public let number: Int
    public let state: String

    public init(owner: String, repo: String, number: Int, state: String) {
        self.owner = owner
        self.repo = repo
        self.number = number
        self.state = state
    }
}
