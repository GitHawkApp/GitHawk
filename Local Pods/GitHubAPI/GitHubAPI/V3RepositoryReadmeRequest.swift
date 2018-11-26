//
//  V3RepositoryReadmeRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3RepositoryReadmeRequest: V3Request {
    public typealias ResponseType = V3DataResponse<V3Content>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "readme"]
    }
    
    public var parameters: [String : Any]? {
        return ["ref" : branch]
    }

    public let owner: String
    public let repo: String
    public let branch: String

    public init(owner: String, repo: String, branch: String) {
        self.owner = owner
        self.repo = repo
        self.branch = branch 
    }
}
