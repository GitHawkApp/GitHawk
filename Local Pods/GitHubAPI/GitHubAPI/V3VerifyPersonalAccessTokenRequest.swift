//
//  V3VerifyPersonalAccessTokenRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3VerifyPersonalAccessTokenRequest: V3Request {
    public typealias ResponseType = V3DataResponse<V3User>
    public var pathComponents: [String] { return ["user"] }
    public var headers: [String : String]? { return ["Authorization": "token \(token)"] }
    public let token: String
    public init(token: String) {
        self.token = token
    }
}
