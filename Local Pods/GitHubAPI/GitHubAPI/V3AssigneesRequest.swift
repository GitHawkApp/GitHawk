//
//  V3AssigneesRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3AssigneesRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3User]>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "assignees"]
    }

    public var parameters: [String : Any]? {
        return ["per_page": 50, "page": page]
    }

    public let owner: String
    public let repo: String
    public let page: Int

    public init(owner: String, repo: String, page: Int) {
        self.owner = owner
        self.repo = repo
        self.page = page
    }
}
