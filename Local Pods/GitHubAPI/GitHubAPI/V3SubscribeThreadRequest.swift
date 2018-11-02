//
//  V3SubscribeThreadRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 6/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3SubscribeThreadRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode200>
    public var pathComponents: [String] {
        return ["notifications", "threads", id, "subscription"]
    }
    public var method: HTTPMethod { return .put }
    public var parameters: [String : Any]? {
        return [
            "ignored": ignore ? "true" : "false"
        ]
    }

    public let id: String
    public let ignore: Bool

    public init(id: String, ignore: Bool) {
        self.id = id
        self.ignore = ignore
    }
}
