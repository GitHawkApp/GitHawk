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
    }

    public typealias ResponseType = V3DataResponse<[V3Issue]>
    public var pathComponents: [String] {
        return ["issues"]
    }
    public var parameters: [String : Any]? {
        return [
            "per_page": 50,
            "page": page,
            "filter": filter.rawValue
        ]
    }

    public let filter: FilterType
    public let page: Int

    public init(filter: FilterType, page: Int) {
        self.filter = filter
        self.page = page
    }

}
