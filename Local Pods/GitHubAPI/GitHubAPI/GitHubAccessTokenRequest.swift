//
//  GitHubAccessTokenRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct GitHubAccessToken: Codable {
    public let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
    }
}

public struct GitHubAccessTokenRequest: HTTPRequest {
    public typealias ResponseType = V3DataResponse<GitHubAccessToken>
    public var url: String { return "https://github.com/login/oauth/access_token" }
    public var logoutOnAuthFailure: Bool { return false }
    public var method: HTTPMethod { return .post }
    public var headers: [String : String]? { return nil }

    public var parameters: [String : Any]? {
        return [
            "code": code,
            "client_id": clientId,
            "client_secret": clientSecret
        ]
    }

    public let code: String
    public let clientId: String
    public let clientSecret: String

    public init(code: String, clientId: String, clientSecret: String) {
        self.code = code
        self.clientId = clientId
        self.clientSecret = clientSecret
    }

}
