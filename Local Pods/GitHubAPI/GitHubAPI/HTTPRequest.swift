//
//  HTTPRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public enum HTTPMethod {
    case get
    case post
    case put
    case patch
    case delete
}

public protocol HTTPRequest: Request {
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    var logoutOnAuthFailure: Bool { get }
}
