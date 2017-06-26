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

    // weak refs to avoid cycles
    weak private var rootViewController: UISplitViewController?

    init(
        sessionManager: GithubSessionManager,
        rootViewController: UISplitViewController
        ) {
        self.sessionManager = sessionManager
        self.rootViewController = rootViewController
        sessionManager.addListener(listener: self)
    }

    // MARK: Public API

    public func showLogin(animated: Bool = false) {
        let nav = UINavigationController(rootViewController: newLoginViewController())
        rootViewController?.present(nav, animated: animated)
    }

    public func resetRootViewController(userSession: GithubUserSession?) {
        guard let userSession = userSession else { return }

        let client = newGithubClient(sessionManager: sessionManager, userSession: userSession)

        let notifications = newNotificationsRootViewController(client: client)
        notifications.navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "bullets-hollow"),
            style: .plain,
            target: self,
            action: #selector(RootNavigationManager.onSettings)
        )

        masterNavigationController?.viewControllers = [notifications]
    }

    public func pushLoginViewController(nav: UINavigationController) {
        let login = newLoginViewController()
        nav.pushViewController(login, animated: true)
    }

    // MARK: GithubSessionListener

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession) {
        rootViewController?.presentedViewController?.dismiss(animated: true)
        resetRootViewController(userSession: userSession)
    }

    func didRemove(
        manager: GithubSessionManager,
        userSessions: [GithubUserSession],
        result: GithubSessionResult
        ) {
        switch result {
        case .changed(let userSession): resetRootViewController(userSession: userSession)
        case .logout: showLogin(animated: true)
        case .unchanged: break
        }
    }

    // MARK: Private API

    private var masterNavigationController: UINavigationController? {
        return rootViewController?.viewControllers.first as? UINavigationController
    }

    private func newLoginViewController() -> UIViewController {
        let controller = UIStoryboard(
            name: "GithubLogin",
            bundle: Bundle(for: AppDelegate.self))
            .instantiateInitialViewController() as! LoginViewController
        controller.client = newGithubClient(sessionManager: sessionManager)
        return controller
    }

    @objc private func onSettings() {
        let settings = newSettingsRootViewController(sessionManager: sessionManager, rootNavigationManager: self)
        rootViewController?.present(settings, animated: true)
    }
    
}
