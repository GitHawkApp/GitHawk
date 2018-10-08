//
//  AppController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/6/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubSession
import GitHubAPI

final class AppController: LoginSplashViewControllerDelegate, GitHubSessionListener {

    private var splitViewController: AppSplitViewController!
    private let sessionManager = GitHubSessionManager()
    private weak var loginViewController: LoginSplashViewController?
    private var appClient: GithubClient?
    private var settingsNavigationController: UINavigationController?
    private var watchAppSync: WatchAppUserSessionSync?
    private var routes = [String: (Routable & RoutePerformable).Type]()

    init() {
        sessionManager.addListener(listener: self)
    }

    func appDidFinishLaunching(with window: UIWindow?) {
        guard let controller = window?.rootViewController as? AppSplitViewController else {
            fatalError("App must be setup with a split view controller")
        }
        splitViewController = controller

        if let focused = sessionManager.focusedUserSession {
            resetViewControllers(userSession: focused)
            resetWatchSync(userSession: focused)
        }
    }

    func appDidBecomeActive() {
        // no need to login if there's a user session
        guard sessionManager.focusedUserSession == nil
        // avoid stacking logins
        && loginViewController == nil
            else { return }
        showLogin(animated: false)
    }

    func performFetch(
        application: UIApplication,
        with completion: @escaping (UIBackgroundFetchResult) -> Void
        ) {
        appClient?.badge.fetch(application: application, handler: completion)
    }

    @discardableResult
    func handle(url: URL) -> Bool {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { return false }
        var params = [String: String]()
        for item in components.queryItems ?? [] {
            params[item.name] = item.value
        }
        return handle(path: url.path, params: params)
    }

    @discardableResult
    func handle(path: String, params: [String: String]) -> Bool {
        guard let routeType = routes[path],
            let route = routeType.from(params: params)
            else { return false }
        return route.perform(
            sessionManager: sessionManager,
            splitViewController: splitViewController
        )
    }

    func register<T: Routable & RoutePerformable>(route: T.Type) {
        routes[T.path] = T.self
    }

    private func resetWatchSync(userSession: GitHubUserSession) {
        watchAppSync = WatchAppUserSessionSync(userSession: userSession)
        watchAppSync?.start()
    }

    private func resetViewControllers(userSession: GitHubUserSession) {
        let appClient = GithubClient(userSession: userSession)
        self.appClient = appClient
        settingsNavigationController = settingsNavigationController
            ?? newSettingsRootViewController(sessionManager: sessionManager)
        // keep settings up to date with the most recent client
        if let settings = settingsNavigationController?.viewControllers.first as? SettingsViewController {
            settings.client = appClient
        }

        splitViewController.reset(viewControllers: [
            newNotificationsRootViewController(client: appClient),
            newSearchRootViewController(client: appClient),
            newBookmarksRootViewController(client: appClient),
            settingsNavigationController ?? UINavigationController() // satisfy compiler
            ])
    }

    private func showLogin(animated: Bool) {
        guard let controller = LoginSplashViewController.make(
            client: Client.make(),
            delegate: self
            )
            else { return }
        loginViewController = controller

        let present: () -> Void = {
            self.splitViewController.present(controller, animated: animated)
        }
        if let presented = splitViewController.presentedViewController {
            presented.dismiss(animated: animated, completion: present)
        } else {
            present()
        }

        // wipe underlying VCs clean. important for ipad (modal)
        splitViewController.resetEmpty()
    }

    // MARK: LoginSplashViewControllerDelegate

    func finishLogin(token: String, authMethod: GitHubUserSession.AuthMethod, username: String) {
        sessionManager.focus(
            GitHubUserSession(token: token, authMethod: authMethod, username: username),
            dismiss: true
        )
    }

    // MARK: GitHubSessionListener

    func didFocus(manager: GitHubSessionManager, userSession: GitHubUserSession, dismiss: Bool) {
        resetViewControllers(userSession: userSession)

        if dismiss {
            splitViewController.presentedViewController?.dismiss(animated: trueUnlessReduceMotionEnabled)
        }

        ShortcutHandler.configure(sessionUsernames: manager.userSessions.compactMap { $0.username })
        if let watch = watchAppSync {
            watch.sync(userSession: userSession)
        } else {
            resetWatchSync(userSession: userSession)
        }
    }

    func didLogout(manager: GitHubSessionManager) {
        showLogin(animated: trueUnlessReduceMotionEnabled)
    }

}
