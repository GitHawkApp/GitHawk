//
//  V3MarkThreadsResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3MarkThreadsStatusCode: V3StatusCodeSuccess {
    public static func success(statusCode: Int) -> Bool {
        return statusCode == 205
    }
}

public struct V3MarkThreadsRequest: V3Request {
    public typealias ResponseType = V3StatusCodeResponse<V3MarkThreadsStatusCode>
    public var pathComponents: [String] {
        return ["notifications", "threads", id]
    }
    public var method: HTTPMethod { return .patch }

    public let id: String
}
