//
//  BookmarkShortcutRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct BookmarkShortcutRoute: Routable {

    public init() {}

    public static func from(params: [String: String]) -> BookmarkShortcutRoute? {
        return BookmarkShortcutRoute()
    }

    public var encoded: [String: String] { return [:] }

    public static var path: String {
        return "com.githawk.shortcut.bookmark"
    }
    
}
