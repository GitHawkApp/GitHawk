//
//  AppDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 4/30/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GithubSessionListener {

    var window: UIWindow?
    let session = GithubSession()
    var showingLogin = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if let controller = window?.rootViewController as? ViewController {
            controller.session = session
        }
        session.addListener(listener: self)
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        showLogin()
    }

    func showLogin(animated: Bool = false) {
        guard showingLogin == false,
            session.authorization == nil,
            let nav = UIStoryboard(
                name: "GithubLogin", 
                bundle: Bundle(for: AppDelegate.self))
                .instantiateInitialViewController() as? UINavigationController,
            let login = nav.viewControllers.first as? LoginViewController
            else { return }
        showingLogin = true
        login.session = session
        window?.rootViewController?.present(nav, animated: animated)
    }

    func hideLogin(animated: Bool = false) {
        showingLogin = false
        window?.rootViewController?.presentedViewController?.dismiss(animated: animated)
    }

    func didAdd(session: GithubSession, authorization: Authorization) {
        hideLogin(animated: true)
    }

    func didRemove(session: GithubSession, authorization: Authorization) {
        showLogin(animated: true)
    }
    
}

