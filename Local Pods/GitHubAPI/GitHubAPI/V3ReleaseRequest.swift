//
//  V3ReleaseRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3ReleaseRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Release]>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "releases", id]
    }

    public let owner: String
    public let repo: String
    public let id: String
}
