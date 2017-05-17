//
//  AppDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var showingLogin = false

    let sessionManager = GithubSessionManager()
    let settingsViewController: UIViewController

    override init() {
        settingsViewController = newSettingsRootViewController(sessionManager: sessionManager)
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        sessionManager.addListener(listener: self)
        resetRootViewController(userSession: sessionManager.focusedUserSession)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        showLogin()
    }

    // MARK: Private API

    fileprivate func newClient(userSession: GithubUserSession? = nil) -> GithubClient {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(configuration: config)
        return GithubClient(sessionManager: sessionManager, networker: manager, userSession: userSession)
    }

    fileprivate func showLogin(animated: Bool = false) {
        guard showingLogin == false,
            sessionManager.focusedUserSession == nil,
            let nav = UIStoryboard(
                name: "GithubLogin",
                bundle: Bundle(for: AppDelegate.self))
                .instantiateInitialViewController() as? UINavigationController,
            let login = nav.viewControllers.first as? LoginViewController
            else { return }
        showingLogin = true
        login.client = newClient()
        window?.rootViewController?.present(nav, animated: animated)
    }

    fileprivate func resetRootViewController(userSession: GithubUserSession?) {
        guard let tab = window?.rootViewController as? UITabBarController,
        let userSession = userSession else { return }

        var viewControllers = [UIViewController]()
        let client = newClient(userSession: userSession)
        viewControllers.append(newNotificationsRootViewController(client: client))
        viewControllers.append(settingsViewController)

        tab.viewControllers = viewControllers
        tab.selectedIndex = 0
    }
    
}

extension AppDelegate: GithubSessionListener {

    func didFocus(manager: GithubSessionManager, userSession: GithubUserSession) {
        showingLogin = false
        window?.rootViewController?.presentedViewController?.dismiss(animated: true)
        resetRootViewController(userSession: userSession)
    }

    func didRemove(manager: GithubSessionManager, userSessions: [GithubUserSession], result: GithubSessionResult) {
        switch result {
        case .changed(let userSession): resetRootViewController(userSession: userSession)
        case .logout: showLogin(animated: true)
        case .unchanged: break
        }
    }

}
