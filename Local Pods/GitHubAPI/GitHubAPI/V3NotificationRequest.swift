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
}
