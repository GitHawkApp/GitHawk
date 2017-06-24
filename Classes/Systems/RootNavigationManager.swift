//
//  RootNavigationManager.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Alamofire

final class RootNavigationManager: GithubSessionListener {

    fileprivate var showingLogin = false

    fileprivate let sessionManager: GithubSessionManager

    // weak refs to avoid cycles
    weak fileprivate var rootTabBarController: UITabBarController?

    init(
        sessionManager: GithubSessionManager,
        rootTabBarController: UITabBarController
        ) {
        self.sessionManager = sessionManager
        self.rootTabBarController = rootTabBarController

        sessionManager.addListener(listener: self)
    }

    // MARK: Public API

    public func showLogin(animated: Bool = false, isInitialLogin: Bool = true) {
        guard showingLogin == false,
            let nav = UIStoryboard(
                name: "GithubLogin",
                bundle: Bundle(for: AppDelegate.self))
                .instantiateInitialViewController() as? UINavigationController,
            let login = nav.viewControllers.first as? LoginViewController
            else { return }
        showingLogin = true
        login.client = newGithubClient(sessionManager: sessionManager)
        login.isInitialLogin = isInitialLogin
        rootTabBarController?.present(nav, animated: animated)
    }

    public func resetRootViewController(userSession: GithubUserSession?) {
        guard let userSession = userSession else { return }

        let selectedIndex = rootTabBarController?.selectedIndex ?? 0
        var viewControllers = [UIViewController]()
        let client = newGithubClient(sessionManager: sessionManager, userSession: userSession)

        viewControllers.append(newNotificationsRootViewController(client: client))
        viewControllers.append(newSettingsRootViewController(sessionManager: sessionManager, rootNavigationManager: self))

        rootTabBarController?.viewControllers = viewControllers
        rootTabBarController?.selectedIndex = selectedIndex
    }

    // MARK: GithubSessionListener

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
    
    func didCancel(manager: GithubSessionManager) {
        showingLogin = false
        rootTabBarController?.presentedViewController?.dismiss(animated: true)
    }

}
