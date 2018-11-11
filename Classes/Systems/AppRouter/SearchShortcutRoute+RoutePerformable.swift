//
//  SearchShortcutRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubSession
import GitHawkRoutes

extension SearchShortcutRoute: RoutePerformable {
    func perform(props: RoutePerformableProps) -> RoutePerformableResult {
        guard let controller = props.splitViewController.masterTabBarController?
            .selectTab(of: SearchViewController.self)
            else { return .error }
        controller.searchBarBecomeFirstResponder()
        return .custom
    }
}
