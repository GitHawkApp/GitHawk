//
//  ManualGraphQLRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct ManualGraphQLResponse: EntityResponse {

    public let data: [String: Any]

    public typealias InputType = Data
    public typealias OutputType = [String: Any]

    public init(input: Data, response: HTTPURLResponse?) throws {
        guard let responseData = try JSONSerialization.jsonObject(with: input) as? [String: Any],
            let data = responseData["data"] as? [String: Any] else {
            throw ResponseError.parsing("GraphQL data not dictionary")
        }
        self.data = data
    }
}

public struct ManualGraphQLRequest: HTTPRequest {
    public typealias ResponseType = ManualGraphQLResponse

    public var url: String { return "https://api.github.com/graphql" }
    public var logoutOnAuthFailure: Bool { return true }
    public var method: HTTPMethod { return .post }
    public var parameters: [String : Any]? { return ["query": query] }
    public var headers: [String : String]? { return nil }

    public let query: String

    public init(query: String) {
        self.query = query
    }
}
