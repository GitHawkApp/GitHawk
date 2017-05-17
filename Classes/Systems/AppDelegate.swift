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
    var rootNavigationManager: RootNavigationManager!
    let settingsViewController: UIViewController

    override init() {
        settingsViewController = newSettingsRootViewController(sessionManager: sessionManager)
        super.init()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        rootNavigationManager = RootNavigationManager(
            sessionManager: sessionManager,
            rootTabBarController: window?.rootViewController as! UITabBarController,
            settingsViewController: settingsViewController
        )
        rootNavigationManager.resetRootViewController(userSession: sessionManager.focusedUserSession)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        rootNavigationManager.showLogin(animated: false)
    }

}
