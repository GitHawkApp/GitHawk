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
    func perform(
        sessionManager: GitHubSessionManager,
        splitViewController: AppSplitViewController,
        client: GithubClient
        ) -> Bool {
        guard let controller = splitViewController.masterTabBarController?.selectTab(of: SearchViewController.self)
            else { return false }
        controller.searchBarBecomeFirstResponder()
        return true
    }
}
