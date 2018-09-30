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

final class RootNavigationManager: GitHubSessionListener {

    private let sessionManager: GitHubSessionManager
    private let splitDelegate = SplitViewControllerDelegate()
    private let tabDelegate = TabBarControllerDelegate()

    // weak refs to avoid cycles
    weak private var rootViewController: UISplitViewController?

    // keep alive between switching accounts
    private var settingsRootViewController: UIViewController?

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
        guard let root = rootViewController else { return }

        let login = newLoginViewController()
        login.modalPresentationStyle = .formSheet

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

        let client = newGithubClient(userSession: userSession)
        self.client = client

        fetchUsernameForMigrationIfNecessary(client: client, userSession: userSession, sessionManager: sessionManager)

        // rebuild the settings VC if it doesn't exist
        settingsRootViewController = settingsRootViewController ?? newSettingsRootViewController(
            sessionManager: sessionManager,
            client: client,
            rootNavigationManager: self
        )

        tabBarController?.viewControllers = [
            newNotificationsRootViewController(client: client),
            newSearchRootViewController(client: client),
            newBookmarksRootViewController(client: client),
            settingsRootViewController ?? UIViewController() // simply satisfying compiler
        ]
    }

    public func pushLoginViewController(nav: UINavigationController) {
        let login = newLoginViewController()
        nav.pushViewController(login, animated: trueUnlessReduceMotionEnabled)
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

    private func fetchUsernameForMigrationIfNecessary(
        client: GithubClient,
        userSession: GitHubUserSession,
        sessionManager: GitHubSessionManager
        ) {
        // only required when there is no username
        guard userSession.username == nil else { return }

        client.client.send(V3VerifyPersonalAccessTokenRequest(token: userSession.token)) { result in
            switch result {
            case .success(let user):
                userSession.username = user.data.login

                // user session ref is same session that manager should be using
                // update w/ mutated session
                sessionManager.save()
            case .failure: break
            }
        }
    }

    var detailNavigationController: UINavigationController? {
        return rootViewController?.viewControllers.last as? UINavigationController
    }

    private var tabBarController: TabBarController? {
        return rootViewController?.viewControllers.first as? TabBarController
    }

    private func newLoginViewController() -> UIViewController {
        let controller = UIStoryboard(
            name: "OauthLogin",
            bundle: Bundle(for: AppDelegate.self))
            .instantiateInitialViewController() as! LoginSplashViewController
        controller.config(
            client: newGithubClient().client,
            sessionManager: sessionManager
        )
        return controller
    }

}
