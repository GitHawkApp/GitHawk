//
//  SwitchAccountShortcutRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession
import GitHawkRoutes

extension SwitchAccountShortcutRoute: RoutePerformable {
    func perform(props: RoutePerformableProps) -> RoutePerformableResult {
        let userSessions = props.sessionManager.userSessions
        guard let needle = userSessions.first(where: { username == $0.username })
            else { return .error }
        props.sessionManager.focus(needle, dismiss: false)
        props.splitViewController.masterTabBarController?.selectTab(of: NotificationsViewController.self)
        return .custom
    }
}
