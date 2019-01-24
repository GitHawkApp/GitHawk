//
//  GitHubAPIStatusRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct APIStatus: Codable {
    public let status: Status
}

public struct Status: Codable {
    public let indicator: StatusType
    public let description: String
    
    public enum StatusType: String, Codable, CodingKey {
        case normal = "none"
        case minor, major, critical
    }
}

public struct GitHubAPIStatusRequest: HTTPRequest {
    public typealias ResponseType = V3DataResponse<APIStatus>
    public var url: String { return "https://www.githubstatus.com/api/v2/status.json" }
    public var logoutOnAuthFailure: Bool { return false }
    public var method: HTTPMethod { return .get }
    public var parameters: [String : Any]? { return nil }
    public var headers: [String : String]? { return nil }
    public init() {}
}
