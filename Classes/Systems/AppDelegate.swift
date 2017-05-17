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

    let client: GithubClient = {
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(configuration: config)
        return GithubClient(session: GithubSession(), networker: manager)
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        client.session.addListener(listener: self)
        resetRootViewController()
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        showLogin()
    }

    // MARK: Private API

    private func showLogin(animated: Bool = false) {
        guard showingLogin == false,
            client.session.authorization == nil,
            let nav = UIStoryboard(
                name: "GithubLogin",
                bundle: Bundle(for: AppDelegate.self))
                .instantiateInitialViewController() as? UINavigationController,
            let login = nav.viewControllers.first as? LoginViewController
            else { return }
        showingLogin = true
        login.client = client
        window?.rootViewController?.present(nav, animated: animated)
    }

    private func hideLogin(animated: Bool = false) {
        showingLogin = false
        window?.rootViewController?.presentedViewController?.dismiss(animated: animated)
        resetRootViewController()
    }

    private func resetRootViewController() {
        guard let tab = window?.rootViewController as? UITabBarController else { return }

        var viewControllers = [UIViewController]()

        let notifications = NotificationsViewController(client: client)
        let notificationsNav = UINavigationController(rootViewController: notifications)
        let title = NSLocalizedString("Notifications", comment: "")
        notifications.navigationItem.title = title
        notificationsNav.tabBarItem.title = title
        notificationsNav.tabBarItem.image = UIImage(named: "inbox")
        viewControllers.append(notificationsNav)

        if let settingsNav = UIStoryboard(name: "Settings", bundle: nil).instantiateInitialViewController() as? UINavigationController,
            let settings = settingsNav.viewControllers.first as? SettingsViewController {
            settings.session = client.session
            viewControllers.append(settingsNav)
        }

        tab.viewControllers = viewControllers
        tab.selectedIndex = 0
    }

    // MARK: GithubSessionListener

    func didAdd(session: GithubSession, authorization: Authorization) {
        hideLogin(animated: true)
    }

    func didRemove(session: GithubSession, authorization: Authorization) {
        showLogin(animated: true)
    }
    
}

