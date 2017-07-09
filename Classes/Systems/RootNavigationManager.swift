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

    init(
        sessionManager: GithubSessionManager,
        rootViewController: UISplitViewController
        ) {
        self.sessionManager = sessionManager
        self.rootViewController = rootViewController
        rootViewController.delegate = splitDelegate
        rootViewController.preferredDisplayMode = .allVisible
        rootViewController.view.backgroundColor = Styles.Colors.background
        sessionManager.addListener(listener: self)
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
    }

    public func pushLoginViewController(nav: UINavigationController) {
        let login = newLoginViewController()
        nav.pushViewController(login, animated: true)
    }

    // MARK: GithubSessionListener

    func didAuthenticate(manager: GithubSessionManager, userSession: GithubUserSession) {
        resetRootViewController(userSession: userSession)
        rootViewController?.presentedViewController?.dismiss(animated: true)
    }

    func didLogout(manager: GithubSessionManager) {
        showLogin(animated: true)
    }

    func didReceiveRedirect(manager: GithubSessionManager, code: String) {}

    // MARK: Private API

    private var masterNavigationController: UINavigationController? {
        return rootViewController?.viewControllers.first as? UINavigationController
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
        let settings = newSettingsRootViewController(sessionManager: sessionManager, rootNavigationManager: self)
        settings.modalPresentationStyle = .formSheet
        rootViewController?.present(settings, animated: true)
    }

}

