//
//  ShortcutHandler.swift
//  Freetime
//
//  Created by Viktor Gardart on 2017-10-08.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ShortcutHandler {

    static private let searchViewControllerIndex = 1
    static private let bookmarksViewControllerIndex = 2

    private enum Items: String {
        case search
        case bookmarks
        case switchAccount
    }

    static func configure(application: UIApplication, sessionManager: GithubSessionManager) {
        application.shortcutItems = generateItems(sessionManager: sessionManager)
    }

    static func handle(shortcutItem item: UIApplicationShortcutItem,
                       sessionManager: GithubSessionManager,
                       navigationManager: RootNavigationManager) -> Bool {
        guard let itemType = Items(rawValue: item.type) else { return false }
        switch itemType {
        case .search:
            navigationManager.selectViewController(atIndex: searchViewControllerIndex)
            return true
        case .bookmarks:
            navigationManager.selectViewController(atIndex: bookmarksViewControllerIndex)
            return true
        case .switchAccount:
            if let index = item.userInfo?["sessionIndex"] as? Int {
                let session = sessionManager.userSessions[index]
                sessionManager.focus(session, dismiss: false)
            }
            return true
        }
    }

    private static func generateItems(sessionManager: GithubSessionManager) -> [UIApplicationShortcutItem] {
        var items: [UIApplicationShortcutItem] = []

        // Search
        let searchIcon = UIApplicationShortcutIcon(templateImageName: Items.search.rawValue)
        let searchItem = UIApplicationShortcutItem(type: Items.search.rawValue,
                                                   localizedTitle: Constants.Strings.search,
                                                   localizedSubtitle: nil,
                                                   icon: searchIcon)
        items.append(searchItem)

        // Bookmarks
        let bookmarkIcon = UIApplicationShortcutIcon(templateImageName: "bookmark")
        let bookmarkItem = UIApplicationShortcutItem(type: Items.bookmarks.rawValue,
                                                   localizedTitle: Constants.Strings.bookmarks,
                                                   localizedSubtitle: nil,
                                                   icon: bookmarkIcon)
        items.append(bookmarkItem)
        
        // Switchuser
        if sessionManager.userSessions.count >= 2 {
            let userSession = sessionManager.userSessions[1]
            if let username = userSession.username {
                let userIcon = UIApplicationShortcutIcon(templateImageName: "organization")
                let userItem = UIApplicationShortcutItem(type: Items.switchAccount.rawValue,
                                                         localizedTitle: NSLocalizedString("Switch Account", comment: ""),
                                                         localizedSubtitle: username,
                                                         icon: userIcon,
                                                         userInfo: ["sessionIndex": 1])
                items.append(userItem)
            }
        }

        return items
    }

}
