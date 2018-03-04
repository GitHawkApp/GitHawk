//
//  V3RepositoryNotificationResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3RepositoryNotificationResponse: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Notification]>
    public var pathComponents: [String] {
        return ["repos", owner, repo, "notifications"]
    }

    public let owner: String
    public let repo: String
}
