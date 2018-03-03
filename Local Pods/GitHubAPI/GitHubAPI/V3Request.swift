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
    var url: String {
        return "https://api.github.com/" + pathComponents.joined(separator: "/")
    }
    public var logoutOnAuthFailure: Bool { return true }
    public var method: HTTPMethod { return .get }
    public var parameters: [String : Any]? { return nil }
    public var headers: [String : String]? { return nil }
}

public struct V3Response<T: Codable>: EntityResponse {

    public let data: T

    public typealias InputType = Data
    public typealias OutputType = T

    public init(input: Data) throws {
        let decoder = JSONDecoder()

        // https://developer.github.com/v3/#schema
        decoder.dateDecodingStrategy = .iso8601

        self.data = try decoder.decode(T.self, from: input)
    }
}
