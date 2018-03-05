//
//  V3MarkNotificationsRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3MarkNotificationsRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3StatusCode205>
    public var pathComponents: [String] {
        return ["notifications"]
    }
    public var method: HTTPMethod { return .put }
    public init() {}
}
