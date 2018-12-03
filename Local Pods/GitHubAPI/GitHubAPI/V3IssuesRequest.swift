//
//  V3IssuesRequest.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 12/2/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3IssuesRequest: V3Request {

    public enum FilterType: String {
        case assigned
        case created
        case mentioned
        case subscribed
        case all
    }

    public typealias ResponseType = V3DataResponse<[V3Issue]>
    public var pathComponents: [String] {
        return ["issues"]
    }
    public var parameters: [String : Any]? {
        return [
            "per_page": 50,
            "filter": filter.rawValue
        ]
    }

    let filter: FilterType

    public init(filter: FilterType) {
        self.filter = filter
    }
}
