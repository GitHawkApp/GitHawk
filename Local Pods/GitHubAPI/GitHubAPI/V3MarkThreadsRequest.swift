//
//  V3MarkThreadsResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3MarkThreadsResponse: EntityResponse {
    public let data: String

    public typealias InputType = Data
    public typealias OutputType = String

    public init(input: Data, response: HTTPURLResponse?) throws {
        // https://developer.github.com/v3/activity/notifications/#mark-a-thread-as-read
        guard response?.statusCode == 205 else {
            throw ResponseError.parsing("Failure marking thread read")
        }
        self.data = "success"
    }
}

public struct V3MarkThreadsRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Notification]>
    public var pathComponents: [String] {
        return ["notifications", "threads", id]
    }

    public let id: String
}
