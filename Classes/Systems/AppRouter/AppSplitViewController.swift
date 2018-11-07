//
//  AppSplitViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/6/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class AppSplitViewController: UISplitViewController {

    private let tabDelegateController = TabBarControllerDelegate()
    private let appSplitViewDelegateController = SplitViewControllerDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        masterTabBarController?.delegate = tabDelegateController
        delegate = appSplitViewDelegateController
        preferredDisplayMode = .allVisible
    }

    var detailNavigationController: UINavigationController? {
        return viewControllers.last as? UINavigationController
    }

    var masterTabBarController: UITabBarController? {
        return viewControllers.first as? UITabBarController
    }

    func resetEmpty() {
        let controller = UIViewController()
        controller.view.backgroundColor = Styles.Colors.background
        reset(viewControllers: [UINavigationController(rootViewController: controller)])
    }

    func reset(viewControllers: [UIViewController]) {
        masterTabBarController?.viewControllers = viewControllers
        detailNavigationController?.viewControllers = [SplitPlaceholderViewController()]
    }

}
