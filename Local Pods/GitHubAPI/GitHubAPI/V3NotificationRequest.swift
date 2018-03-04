//
//  V3NotificationResponse.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3NotificationRequest: V3Request {
    public typealias ResponseType = V3DataResponse<[V3Notification]>
    public let pathComponents: [String] = ["notifications"]
    public var parameters: [String : Any]? {
        return [
            "all": all ? "true" : "false",
            "participating": "false",
            "page": page,
            "per_page": "50"
        ]
    }
    public let all: Bool
    public let page: Int

    public init(all: Bool = true, page: Int? = nil) {
        self.all = all
        self.page = page ?? 1
    }
}
