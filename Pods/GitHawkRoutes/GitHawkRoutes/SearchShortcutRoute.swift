//
//  SearchShortcutRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

public struct SearchShortcutRoute: Routable {

    public init() {}

    public static func from(params: [String: String]) -> SearchShortcutRoute? {
        return SearchShortcutRoute()
    }
    
}
