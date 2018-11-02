//
//  SwitchAccountShortcutRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct SwitchAccountShortcutRoute: Routable {

    public let username: String

    public init(username: String) {
        self.username = username
    }

    public static func from(params: [String: String]) -> SwitchAccountShortcutRoute? {
        guard let username = params["username"] else { return nil }
        return SwitchAccountShortcutRoute(username: username)
    }

    public var encoded: [String: String] {
        return [
            "username": username
        ]
    }
    
}
