//
//  V3MilestoneRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3MilestoneRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Milestone]>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "milestones"]
    }

    public let owner: String
    public let repo: String

    public init(owner: String, repo: String) {
        self.owner = owner
        self.repo = repo
    }
}
