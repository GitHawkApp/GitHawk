//
//  Response.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public enum ResponseError: Error {
    case parsing(String?)
}

public protocol Response {
    associatedtype InputType
    associatedtype OutputType
    init(input: InputType, response: HTTPURLResponse?) throws
}

public protocol EntityResponse: Response {
    var data: OutputType { get }
}

public protocol CollectionResponse: Response {
    var data: [OutputType] { get }
}
