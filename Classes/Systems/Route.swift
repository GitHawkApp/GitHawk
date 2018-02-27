//
//  Navigation.swift
//  Freetime
//
//  Created by Rizwan on 26/02/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

enum Route {
    case tab(TabBarController.Tab)
    case switchAccount(sessionIndex: Int?)

    init?(shortcutItem: UIApplicationShortcutItem) {
        guard let itemType = ShortcutHandler.Items(rawValue: shortcutItem.type) else { return nil }
        switch itemType {
        case .search: self = .tab(.search)
        case .bookmarks: self = .tab(.bookmarks)
        case .switchAccount: self = .switchAccount(sessionIndex: shortcutItem.userInfo?["sessionIndex"] as? Int)
        }
    }
}
