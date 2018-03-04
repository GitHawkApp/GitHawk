//
//  V3DeleteCommentRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3DeleteCommentStatusCode: V3StatusCodeSuccess {
    public static func success(statusCode: Int) -> Bool {
        return statusCode == 204
    }
}

public struct V3DeleteCommentRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3DeleteCommentStatusCode>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "issues", "comments", commentID]
    }
    public var method: HTTPMethod { return .delete }

    public let owner: String
    public let repo: String
    public let commentID: String
}
