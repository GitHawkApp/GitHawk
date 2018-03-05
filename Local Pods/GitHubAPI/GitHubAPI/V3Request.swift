//
//  GitHubAPIRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public protocol V3Request: HTTPRequest {

    var pathComponents: [String] { get }

}

public extension V3Request {
    var url: String { return "https://api.github.com/" + pathComponents.joined(separator: "/") }
    public var logoutOnAuthFailure: Bool { return true }
    public var method: HTTPMethod { return .get }
    public var parameters: [String : Any]? { return nil }
    public var headers: [String : String]? { return nil }
}
