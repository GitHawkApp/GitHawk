//
//  V3MergePullRequestRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public enum MergeType: String {
    case merge
    case rebase
    case squash
}

public struct V3MergePullRequestRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode200>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "pulls", "\(number)", "merge"]
    }
    public var method: HTTPMethod { return .put }
    public var parameters: [String : Any]? {
        return ["merge_method": type.rawValue]
    }

    public let owner: String
    public let repo: String
    public let number: Int
    public let type: MergeType

    public init(owner: String, repo: String, number: Int, type: MergeType) {
        self.owner = owner
        self.repo = repo
        self.number = number
        self.type = type
    }
}
