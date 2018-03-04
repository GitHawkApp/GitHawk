//
//  V3SetMilestonesRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3SetMilestonesRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode200>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "issues", "\(number)"]
    }
    public var method: HTTPMethod { return .patch }
    public var parameters: [String : Any]? {
        return ["milestone": milestoneNumber ?? NSNull()]
    }

    public let owner: String
    public let repo: String
    public let number: Int
    public let milestoneNumber: Int?

    public init(owner: String, repo: String, number: Int, milestoneNumber:Int?) {
        self.owner = owner
        self.repo = repo
        self.number = number
        self.milestoneNumber = milestoneNumber
    }
}
