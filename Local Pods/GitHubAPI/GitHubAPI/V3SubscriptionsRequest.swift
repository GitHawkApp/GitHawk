//
//  V3SubscriptionsRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3SubscriptionsRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Repository]>
    public var pathComponents: [String] {
        return ["users", username, "subscriptions"]
    }
    public var parameters: [String : Any]? { return [:] }

    public let username: String

    public init(username: String) {
        self.username = username
    }
}
