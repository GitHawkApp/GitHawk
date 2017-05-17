//
//  RootNavigationManager.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Alamofire

final class RootNavigationManager {

    fileprivate var showingLogin = false

    fileprivate let sessionManager: GithubSessionManager

    // weak refs to avoid cycles
    weak fileprivate var settingsViewController: UIViewController?
    weak fileprivate var rootTabBarController: UITabBarController?

    init(
        sessionManager: GithubSessionManager,
        rootTabBarController: UITabBarController,
        settingsViewController: UIViewController
        ) {
        self.sessionManager = sessionManager
        self.rootTabBarController = rootTabBarController
        self.settingsViewController = settingsViewController

        sessionManager.addListener(listener: self)
    }

    // MARK: Public API

    public func showLogin(animated: Bool = false) {
        guard showingLogin == false,
            sessionManager.focusedUserSession == nil,
            let nav = UIStoryboard(
                name: "GithubLogin",
                bundle: Bundle(for: AppDelegate.self))
                .instantiateInitialViewController() as? UINavigationController,
            let login = nav.viewControllers.first as? LoginViewController
            else { return }
        showingLogin = true
        login.client = newGithubClient(sessionManager: sessionManager)
        rootTabBarController?.present(nav, animated: animated)
    }

    public func resetRootViewController(userSession: GithubUserSession?) {
        guard let userSession = userSession else { return }

        let selectedIndex = rootTabBarController?.selectedIndex ?? 0

        var viewControllers = [UIViewController]()
        let client = newGithubClient(sessionManager: sessionManager, userSession: userSession)
        viewControllers.append(newNotificationsRootViewController(client: client))

        if let settings = settingsViewController {
            viewControllers.append(settings)
        }

        rootTabBarController?.viewControllers = viewControllers
        rootTabBarController?.selectedIndex = selectedIndex
    }

}

extension RootNavigationManager: GithubSessionListener {

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession) {
        showingLogin = false
        rootTabBarController?.presentedViewController?.dismiss(animated: true)
        resetRootViewController(userSession: userSession)
    }

    func didRemove(manager: GithubSessionManager, userSessions: [GithubUserSession], result: GithubSessionResult) {
        switch result {
        case .changed(let userSession): resetRootViewController(userSession: userSession)
        case .logout: showLogin(animated: true)
        case .unchanged: break
        }
    }

}
