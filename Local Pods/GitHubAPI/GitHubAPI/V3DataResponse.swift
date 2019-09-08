//
//  V3DataResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3DataResponse<T: Codable>: EntityResponse {

    public let data: T
    public let next: Int?

    public typealias InputType = Data
    public typealias OutputType = T

    public init(input: Data, response: HTTPURLResponse?) throws {
        let decoder = JSONDecoder()

        // https://developer.github.com/v3/#schema
        decoder.dateDecodingStrategy = .iso8601
        self.data = try decoder.decode(T.self, from: input)
        self.next = (response?.allHeaderFields["Link"] as? String)?.httpNextPageNumber
    }
}
