//
//  V3StatusCodeResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public protocol V3StatusCodeSuccess {
    static func success(statusCode: Int) -> Bool
}

public struct V3StatusCodeResponse<T: V3StatusCodeSuccess>: EntityResponse {
    public let data: String

    public typealias InputType = Data
    public typealias OutputType = String

    public init(input: Data, response: HTTPURLResponse?) throws {
        // https://developer.github.com/v3/activity/notifications/#mark-a-thread-as-read
        guard let statusCode = response?.statusCode,
            T.success(statusCode: statusCode) else {
            throw ResponseError.parsing("Status code failure for \(response?.url?.absoluteString ?? "n/a")")
        }
        self.data = "success"
    }
}
