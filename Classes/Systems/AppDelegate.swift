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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var showingLogin = false
    private let flexController = FlexController()
    private let sessionManager = GithubSessionManager()

    private lazy var rootNavigationManager: RootNavigationManager = {
        return RootNavigationManager(
            sessionManager: self.sessionManager,
            rootViewController: self.window?.rootViewController as! UISplitViewController
        )
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // initialize a webview at the start so webview startup later on isn't so slow
        let _ = UIWebView()
        flexController.configureWindow(window)
        window?.backgroundColor = Styles.Colors.background
        rootNavigationManager.resetRootViewController(userSession: sessionManager.userSession)
        NetworkActivityIndicatorManager.shared.isEnabled = true
        Styles.setupAppearance()
        BadgeNotifications.configure(application: application)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        if showingLogin == false && sessionManager.userSession == nil {
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
        BadgeNotifications.fetch(application: application, handler: completionHandler)
    }
    
}
