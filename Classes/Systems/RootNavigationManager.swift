//
//  RootNavigationManager.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Alamofire

final class RootNavigationManager: GithubSessionListener {

    private let sessionManager: GithubSessionManager
    private let splitDelegate = SplitViewControllerDelegate()
    private let tabDelegate = TabBarControllerDelegate()

    // weak refs to avoid cycles
    weak private var rootViewController: UISplitViewController?

    // keep alive between switching accounts
    private var settingsRootViewController: UIViewController? = nil

    private var lastClient: GithubClient? = nil

    init(
        sessionManager: GithubSessionManager,
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

        let block: () -> () = { root.present(login, animated: animated) }

        if let presented = root.presentedViewController {
            presented.dismiss(animated: animated, completion: block)
        } else {
            block()
        }
    }

    public func resetRootViewController(userSession: GithubUserSession?) {
        guard let userSession = userSession else { return }

        let client = newGithubClient(sessionManager: sessionManager, userSession: userSession)
        lastClient = client

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
            settingsRootViewController ?? UIViewController(), // simply satisfying compiler
        ]
    }

    public func pushLoginViewController(nav: UINavigationController) {
        let login = newLoginViewController()
        nav.pushViewController(login, animated: true)
    }

    // MARK: GithubSessionListener

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession, dismiss: Bool) {
        resetRootViewController(userSession: userSession)

        if dismiss {
            rootViewController?.presentedViewController?.dismiss(animated: true)
        }
    }

    func didLogout(manager: GithubSessionManager) {
        settingsRootViewController = nil

        for vc in tabBarController?.viewControllers ?? [] {
            if let nav = vc as? UINavigationController {
                nav.viewControllers = [SplitPlaceholderViewController()]
            }
        }

        detailNavigationController?.viewControllers = [SplitPlaceholderViewController()]
        showLogin(animated: true)
    }

    func didReceiveRedirect(manager: GithubSessionManager, code: String) {}

    // MARK: Private API

    private func fetchUsernameForMigrationIfNecessary(
        client: GithubClient,
        userSession: GithubUserSession,
        sessionManager: GithubSessionManager
        ) {
        // only required when there is no username
        guard userSession.username == nil else { return }

        client.verifyPersonalAccessToken(token: userSession.token) { result in
            switch result {
            case .success(let user):
                userSession.username = user.username

                // user session ref is same session that manager should be using
                // update w/ mutated session
                sessionManager.save()
            default: break
            }
        }
    }

    private var detailNavigationController: UINavigationController? {
        return rootViewController?.viewControllers.last as? UINavigationController
    }
    
    private var tabBarController: UITabBarController? {
        return rootViewController?.viewControllers.first as? UITabBarController
    }

    private func newLoginViewController() -> UIViewController {
        let controller = UIStoryboard(
            name: "OauthLogin",
            bundle: Bundle(for: AppDelegate.self))
            .instantiateInitialViewController() as! LoginSplashViewController
        controller.client = newGithubClient(sessionManager: sessionManager)
        return controller
    }

}

