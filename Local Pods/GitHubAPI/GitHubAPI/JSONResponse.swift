//
//  JSONResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct JSONResponse<T>: EntityResponse {

    public let data: T

    public typealias InputType = Data
    public typealias OutputType = T

    public init(input: Data, response: HTTPURLResponse?) throws {
        guard let responseData = try JSONSerialization.jsonObject(with: input) as? T else {
                throw ResponseError.parsing("Mismatched root JSON object")
        }
        self.data = responseData
    }
}
