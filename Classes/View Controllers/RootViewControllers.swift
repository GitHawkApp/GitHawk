//
//  RootViewControllers.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubSession

func newSettingsRootViewController(
    sessionManager: GitHubSessionManager,
    client: GithubClient,
    rootNavigationManager: RootNavigationManager
    ) -> UIViewController {
    guard let controller = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController()
        else { fatalError("Could not unpack settings storyboard") }

    if let nav = controller as? UINavigationController,
        let first = nav.viewControllers.first as? SettingsViewController {
        first.client = client
        first.sessionManager = sessionManager
        first.rootNavigationManager = rootNavigationManager
        nav.tabBarItem.title = NSLocalizedString("Settings", comment: "")
        nav.tabBarItem.image = UIImage(named: "tab-gear")?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage(named: "tab-gear-selected")?.withRenderingMode(.alwaysOriginal)
    }

    return controller
}

func newNotificationsRootViewController(client: GithubClient) -> UIViewController {
    let controller = NotificationsViewController2(
        modelController: NotificationModelController(githubClient: client),
        inboxType: .unread
    )
    let title = NSLocalizedString("Inbox", comment: "")
    controller.title = title
    let nav = UINavigationController(rootViewController: controller)
    nav.tabBarItem.title = title
    nav.tabBarItem.image = UIImage(named: "tab-inbox")?.withRenderingMode(.alwaysOriginal)
    nav.tabBarItem.selectedImage = UIImage(named: "tab-inbox-selected")?.withRenderingMode(.alwaysOriginal)
    return nav
}

func newSearchRootViewController(client: GithubClient) -> UIViewController {
    let controller = SearchViewController(client: client)
    let nav = UINavigationController(rootViewController: controller)
    nav.tabBarItem.title = Constants.Strings.search
    nav.tabBarItem.image = UIImage(named: "tab-search")?.withRenderingMode(.alwaysOriginal)
    nav.tabBarItem.selectedImage = UIImage(named: "tab-search-selected")?.withRenderingMode(.alwaysOriginal)
    return nav
}

func newBookmarksRootViewController(client: GithubClient) -> UIViewController {
    let title = Constants.Strings.bookmarks
    let controller = BookmarkViewController(client: client)
    controller.makeBackBarItemEmpty()
    controller.title = title
    let nav = UINavigationController(rootViewController: controller)
    nav.tabBarItem.image = UIImage(named: "tab-bookmark")?.withRenderingMode(.alwaysOriginal)
    nav.tabBarItem.selectedImage = UIImage(named: "tab-bookmark-selected")?.withRenderingMode(.alwaysOriginal)
    nav.tabBarItem.title = title
    return nav
}
