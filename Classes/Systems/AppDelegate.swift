//
//  AppDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireNetworkActivityIndicator
import Fabric
import Crashlytics
import GitHubSession

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var showingLogin = false
    private let flexController = FlexController()
    private let sessionManager = GitHubSessionManager()
    private var badgeNotifications: BadgeNotifications?
    private var watchAppSync: WatchAppUserSessionSync?

    private lazy var rootNavigationManager: RootNavigationManager = {
        return RootNavigationManager(
            sessionManager: self.sessionManager,
            rootViewController: self.window?.rootViewController as! UISplitViewController
        )
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        sessionManager.addListener(listener: self)

        let focusedSession = sessionManager.focusedUserSession
        watchAppSync = WatchAppUserSessionSync(userSession: focusedSession)
        watchAppSync?.start()

        // initialize a webview at the start so webview startup later on isn't so slow
        _ = UIWebView()

        // setup fabric
        Fabric.with([Crashlytics.self])

        // send rating prompt app load event
        RatingController.applicationDidLaunch()

        // setup FLEX
        flexController.configureWindow(window)

        // setup root VCs
        window?.backgroundColor = Styles.Colors.background
        rootNavigationManager.resetRootViewController(userSession: focusedSession)

        // use Alamofire status bar network activity helper
        NetworkActivityIndicatorManager.shared.isEnabled = true

        // setup UIAppearance overrides
        Styles.setupAppearance()

        // setup app icon badging
        BadgeNotifications.configure(application: application)

        // log device environment information
        LogEnvironmentInformation(application: application)

        return true
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        guard let route = Route(shortcutItem: shortcutItem) else {
            completionHandler(false)
            return
        }
        completionHandler(ShortcutHandler.handle(
            route: route,
            sessionManager: sessionManager,
            navigationManager: rootNavigationManager))
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if showingLogin == false && sessionManager.focusedUserSession == nil {
            showingLogin = true
            rootNavigationManager.showLogin(animated: false)
        }
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let sourceApp = options[.sourceApplication],
            String(describing: sourceApp) == "com.apple.SafariViewService" {
            sessionManager.receivedCodeRedirect(url: url)
            return true
        }
        return false
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        badgeNotifications = BadgeNotifications()
        badgeNotifications?.fetch(application: application, handler: completionHandler)
    }

}

extension AppDelegate: GitHubSessionListener {

     // configure 3d touch shortcut handling
    func didFocus(manager: GitHubSessionManager, userSession: GitHubUserSession, dismiss: Bool) {
        ShortcutHandler.configure(application: UIApplication.shared, sessionManager: sessionManager)
        watchAppSync?.sync(userSession: userSession)
    }

    func didReceiveRedirect(manager: GitHubSessionManager, code: String) {}
    func didLogout(manager: GitHubSessionManager) {}
}
