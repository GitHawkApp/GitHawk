//
//  V3LockIssueRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3LockIssueStatusCode: V3StatusCodeSuccess {
    public static func success(statusCode: Int) -> Bool {
        return statusCode == 204
    }
}

public struct V3LockIssueRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3LockIssueStatusCode>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "issues", id, "lock"]
    }
    public var method: HTTPMethod {
        return locked ? .put : .delete
    }

    public let owner: String
    public let repo: String
    public let id: String
    public let locked: Bool
}
