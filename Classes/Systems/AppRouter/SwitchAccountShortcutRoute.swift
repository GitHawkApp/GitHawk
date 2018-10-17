//
//  SwitchAccountShortcutRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession

struct SwitchAccountShortcutRoute: Routable {
    let username: String
    static func from(params: [String: String]) -> SwitchAccountShortcutRoute? {
        guard let username = params["username"] else { return nil }
        return SwitchAccountShortcutRoute(username: username)
    }
    var encoded: [String: String] {
        return ["username": username]
    }
    static var path: String {
        return "com.githawk.shortcut.switch"
    }
}

extension SwitchAccountShortcutRoute: RoutePerformable {
    func perform(
        sessionManager: GitHubSessionManager,
        splitViewController: AppSplitViewController,
        client: GithubClient
        ) -> Bool {
        let userSessions = sessionManager.userSessions
        guard let needle = userSessions.first(where: { username == $0.username })
            else { return false }
        sessionManager.focus(needle, dismiss: false)
        splitViewController.masterTabBarController?.selectTab(of: NotificationsViewController.self)
        return true
    }
}
