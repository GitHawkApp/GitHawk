//
//  V3EditCommentRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3EditCommentRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode200>
    public var pathComponents: [String] {
        if isRoot {
            return ["repos", owner, repo, "issues", "\(issueNumber)"]
        } else if isInPullRequestReview {
            return ["repos", owner, repo, "pulls", "comments", "\(commentID)"]
        }
         return ["repos", owner, repo, "issues", "comments", "\(commentID)"]
    }
    public var method: HTTPMethod { return .patch }
    public var parameters: [String : Any]? { return ["body": body] }

    public let owner: String
    public let repo: String
    public let issueNumber: Int
    public let commentID: Int
    public let body: String
    public let isRoot: Bool
    public let isInPullRequestReview: Bool

    public init(owner: String, repo: String, issueNumber: Int, commentID: Int, body: String, isRoot: Bool, isInPullRequestReview: Bool) {
        self.owner = owner
        self.repo = repo
        self.issueNumber = issueNumber
        self.commentID = commentID
        self.body = body
        self.isRoot = isRoot
        self.isInPullRequestReview = isInPullRequestReview
    }
}
