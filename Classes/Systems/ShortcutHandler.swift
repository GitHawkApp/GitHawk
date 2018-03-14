//
//  ShortcutHandler.swift
//  Freetime
//
//  Created by Viktor Gardart on 2017-10-08.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession

struct ShortcutHandler {

    enum Items: String {
        case search
        case bookmarks
        case switchAccount
    }

    static func configure(application: UIApplication, sessionManager: GitHubSessionManager) {
        application.shortcutItems = generateItems(sessionManager: sessionManager)
    }

    static func handle(
        route: Route,
        sessionManager: GitHubSessionManager,
        navigationManager: RootNavigationManager
        ) -> Bool {
        switch route {
        case .tab(let tab):
            navigationManager.selectViewController(atTab: tab)
            return true
        case .switchAccount(let sessionIndex):
            if let index = sessionIndex {
                let session = sessionManager.userSessions[index]
                sessionManager.focus(session, dismiss: false)
            }
            return true
        }
    }

    private static func generateItems(sessionManager: GitHubSessionManager) -> [UIApplicationShortcutItem] {
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
        if sessionManager.userSessions.count > 1 {
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
