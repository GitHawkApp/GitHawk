//
//  RootViewControllers.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func newSettingsRootViewController(
    sessionManager: GithubSessionManager,
    rootNavigationManager: RootNavigationManager
    ) -> UIViewController {
    guard let controller = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController()
        else { fatalError("Could not unpack settings storyboard") }

    if let nav = controller as? UINavigationController,
        let first = nav.viewControllers.first as? SettingsViewController2 {
        first.sessionManager = sessionManager
        first.rootNavigationManager = rootNavigationManager
    }

    return controller

//    let controller = SettingsViewController(
//        sessionManager: sessionManager,
//        rootNavigationManager: rootNavigationManager
//    )
//    let nav = UINavigationController(rootViewController: controller)
//    let title = NSLocalizedString("Settings", comment: "")
//    controller.navigationItem.title = title
//    nav.tabBarItem.title = title
//    nav.tabBarItem.image = UIImage(named: "gear")
//    return nav
}

func newNotificationsRootViewController(client: GithubClient) -> UIViewController {
    let controller = NotificationsViewController(client: client)
    let title = NSLocalizedString("Notifications", comment: "")
    controller.navigationItem.title = title
    controller.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    return controller
//    let nav = UINavigationController(rootViewController: controller)
//    nav.tabBarItem.title = title
//    nav.tabBarItem.image = UIImage(named: "inbox")
//    return nav
}
