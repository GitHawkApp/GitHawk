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
class AppDelegate: UIResponder, UIApplicationDelegate, GithubSessionListener {

    var window: UIWindow?
    var showingLogin = false

    let session = GithubSession()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        session.addListener(listener: self)
        resetRootViewController(authorization: session.authorizations().first)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        showLogin()
    }

    // MARK: Private API

    private func newClient(authorization: Authorization? = nil) -> GithubClient {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(configuration: config)
        return GithubClient(session: session, networker: manager, authorization: authorization)
    }

    private func showLogin(animated: Bool = false) {
        guard showingLogin == false,
            session.authorizations().first == nil,
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

    private func resetRootViewController(authorization: Authorization?) {
        guard let tab = window?.rootViewController as? UITabBarController,
        let authorization = authorization else { return }

        var viewControllers = [UIViewController]()
        let client = newClient(authorization: authorization)

        let notifications = NotificationsViewController(client: client)
        let notificationsNav = UINavigationController(rootViewController: notifications)
        let title = NSLocalizedString("Notifications", comment: "")
        notifications.navigationItem.title = title
        notificationsNav.tabBarItem.title = title
        notificationsNav.tabBarItem.image = UIImage(named: "inbox")
        viewControllers.append(notificationsNav)

        if let settingsNav = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController() as? UINavigationController,
            let settings = settingsNav.viewControllers.first as? SettingsViewController {
            settings.session = session
            viewControllers.append(settingsNav)
        }

        tab.viewControllers = viewControllers
        tab.selectedIndex = 0
    }

    // MARK: GithubSessionListener

    func didAdd(session: GithubSession, authorization: Authorization) {
        showingLogin = false
        window?.rootViewController?.presentedViewController?.dismiss(animated: true)
        resetRootViewController(authorization: authorization)
    }

    func didRemove(session: GithubSession, authorization: Authorization) {
        showLogin(animated: true)
    }
    
}

