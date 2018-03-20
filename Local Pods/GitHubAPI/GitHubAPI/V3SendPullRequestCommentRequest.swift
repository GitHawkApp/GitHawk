//
//  V3SendPullRequestCommentRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3SendPullRequestCommentResponse: EntityResponse {

    public let data: [String: Any]
    public let id: Int

    public typealias InputType = Data
    public typealias OutputType = [String: Any]

    public init(input: Data, response: HTTPURLResponse?) throws {
        guard let responseData = try JSONSerialization.jsonObject(with: input) as? [String: Any],
            let id = responseData["id"] as? Int else {
                throw ResponseError.parsing("PR comment reply json mismatch")
        }
        self.id = id
        self.data = responseData
    }
}

public struct V3SendPullRequestCommentRequest: V3Request {
    public typealias ResponseType = V3SendPullRequestCommentResponse
    public var pathComponents: [String] {
        return ["repos", owner, repo, "pulls", "\(number)", "comments"]
    }
    public var method: HTTPMethod { return .post }
    public var parameters: [String : Any]? {
        return [
            "body": body,
            "in_reply_to": inReplyTo
        ]
    }

    public let owner: String
    public let repo: String
    public let number: Int
    public let body: String
    public let inReplyTo: Int

    public init(owner: String, repo: String, number: Int, body: String, inReplyTo: Int) {
        self.owner = owner
        self.repo = repo
        self.number = number
        self.body = body
        self.inReplyTo = inReplyTo
    }
}
