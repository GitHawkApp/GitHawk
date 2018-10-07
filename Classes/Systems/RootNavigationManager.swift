//
//  RootNavigationManager.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubAPI
import GitHubSession

final class RootNavigationManager: GitHubSessionListener, LoginSplashViewControllerDelegate {

    private let sessionManager: GitHubSessionManager
    private let splitDelegate = SplitViewControllerDelegate()
    private let tabDelegate = TabBarControllerDelegate()

    // weak refs to avoid cycles
    weak private var rootViewController: UISplitViewController?

    // keep alive between switching accounts
    private var settingsRootViewController: UINavigationController?

    private(set) var client: GithubClient?

    init(
        sessionManager: GitHubSessionManager,
        rootViewController: UISplitViewController
        ) {
        self.sessionManager = sessionManager
        self.rootViewController = rootViewController
        rootViewController.delegate = splitDelegate
        rootViewController.preferredDisplayMode = .allVisible
        sessionManager.addListener(listener: self)

        self.tabBarController?.tabBar.tintColor = Styles.Colors.Blue.medium.color
        self.tabBarController?.tabBar.unselectedItemTintColor = Styles.Colors.Gray.light.color
        self.tabBarController?.delegate = self.tabDelegate
    }

    // MARK: Public API

    public func showLogin(animated: Bool = false) {
        guard let root = rootViewController,
            let login = LoginSplashViewController.make(
                client: Client.make(),
                delegate: self
            )
            else { return }

        let block: () -> Void = { root.present(login, animated: animated) }

        if let presented = root.presentedViewController {
            presented.dismiss(animated: animated, completion: block)
        } else {
            block()
        }

        self.tabBarController?.selectedIndex = 0
    }

    public func resetRootViewController(userSession: GitHubUserSession?) {
        guard let userSession = userSession else { return }

        let client = GithubClient(userSession: userSession)
        self.client = client

        // rebuild the settings VC if it doesn't exist
        settingsRootViewController = settingsRootViewController ?? newSettingsRootViewController(
            sessionManager: sessionManager
        )
        if let settings = settingsRootViewController?.viewControllers.first as? SettingsViewController {
            settings.client = client
        }

        tabBarController?.viewControllers = [
            newNotificationsRootViewController(client: client),
            newSearchRootViewController(client: client),
            newBookmarksRootViewController(client: client),
            settingsRootViewController ?? UIViewController() // simply satisfying compiler
        ]
    }

    @discardableResult
    public func selectViewController(atIndex index: Int) -> UIViewController? {
        tabBarController?.selectedIndex = index
        return tabBarController?.selectedViewController
    }

    @discardableResult
    public func selectViewController(atTab tab: TabBarController.Tab) -> UIViewController? {
        tabBarController?.showTab(tab)
        return tabBarController?.selectedViewController
    }

    // MARK: GitHubSessionListener

    func didFocus(manager: GitHubSessionManager, userSession: GitHubUserSession, dismiss: Bool) {
        resetRootViewController(userSession: userSession)

        if dismiss {
            rootViewController?.presentedViewController?.dismiss(animated: trueUnlessReduceMotionEnabled)
        }
    }

    func didLogout(manager: GitHubSessionManager) {
        settingsRootViewController = nil

        for vc in tabBarController?.viewControllers ?? [] {
            if let nav = vc as? UINavigationController {
                nav.viewControllers = [SplitPlaceholderViewController()]
            }
        }

        detailNavigationController?.viewControllers = [SplitPlaceholderViewController()]
        showLogin(animated: trueUnlessReduceMotionEnabled)
    }

    func didReceiveRedirect(manager: GitHubSessionManager, code: String) {}

    // MARK: Private API

    private var detailNavigationController: UINavigationController? {
        return rootViewController?.viewControllers.last as? UINavigationController
    }

    private var tabBarController: TabBarController? {
        return rootViewController?.viewControllers.first as? TabBarController
    }

    // MARK: LoginSplashViewControllerDelegate

    func finishLogin(token: String, authMethod: GitHubUserSession.AuthMethod, username: String) {
        sessionManager.focus(
            GitHubUserSession(token: token, authMethod: authMethod, username: username),
            dismiss: true
        )
    }

}
