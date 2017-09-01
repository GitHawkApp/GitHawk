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

    private let sessionManager: GithubSessionManager
    private let splitDelegate = SplitViewControllerDelegate()

    // weak refs to avoid cycles
    weak private var rootViewController: UISplitViewController?

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
        
        tabBarController?.tabBar.tintColor = Styles.Colors.Blue.medium.color
        tabBarController?.tabBar.unselectedItemTintColor = Styles.Colors.Gray.light.color
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

        let notifications = newNotificationsRootViewController(client: client)
        let settingsBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(RootNavigationManager.onSettings)
        )
        settingsBarButtonItem.accessibilityLabel = NSLocalizedString("Settings", comment: "")
        notifications.navigationItem.leftBarButtonItem = settingsBarButtonItem

        masterNavigationController?.viewControllers = [notifications]
        
        let searchViewController = SearchViewController(client: client)
        let searchNavigationController = UINavigationController(rootViewController: searchViewController)
        searchNavigationController.tabBarItem.image = UIImage(named: "search")
        searchNavigationController.tabBarItem.title = NSLocalizedString("Search", comment: "")
        tabBarController?.viewControllers?.append(searchNavigationController)
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
        masterNavigationController?.viewControllers = [SplitPlaceholderViewController()]
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

    private var masterNavigationController: UINavigationController? {
        return tabBarController?.viewControllers?.first as? UINavigationController
    }

    private var detailNavigationController: UINavigationController? {
        guard let controllers = rootViewController?.viewControllers, controllers.count > 1
            else { return nil }
        return controllers[1] as? UINavigationController
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

    @objc private func onSettings() {
        guard let client = lastClient else { return }

        let settings = newSettingsRootViewController(
            sessionManager: sessionManager,
            rootNavigationManager: self,
            client: client
        )
        settings.modalPresentationStyle = .formSheet
        rootViewController?.present(settings, animated: true)
    }

}

