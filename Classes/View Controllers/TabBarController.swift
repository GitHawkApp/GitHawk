//
//  TabBarController.swift
//  Freetime
//
//  Created by Rizwan on 26/02/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

final class TabBarController: UITabBarController {
    enum Tab: Int {
        case inbox = 0
        case search = 1
        case bookmarks = 2
        case settings = 3
    }

    func showTab(_ tab: Tab) {
        selectedIndex = tab.rawValue
    }
}
