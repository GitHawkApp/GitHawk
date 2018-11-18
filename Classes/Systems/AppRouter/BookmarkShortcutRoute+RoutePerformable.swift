//
//  BookmarkShortcutRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession
import GitHawkRoutes

extension BookmarkShortcutRoute: RoutePerformable {
    func perform(props: RoutePerformableProps) -> RoutePerformableResult {
        if props.splitViewController.masterTabBarController?
            .selectTab(of: BookmarkViewController.self) != nil {
            return .custom
        }
        return .error
    }
}
