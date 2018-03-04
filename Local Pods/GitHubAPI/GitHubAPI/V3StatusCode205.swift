//
//  V3StatusCode205.swift
//  GitHubAPI
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct V3StatusCode205: V3StatusCodeSuccess {
    public static func success(statusCode: Int) -> Bool {
        return statusCode == 205
    }
}

public struct V3StatusCode200: V3StatusCodeSuccess {
    public static func success(statusCode: Int) -> Bool {
        return statusCode == 200
    }
}
