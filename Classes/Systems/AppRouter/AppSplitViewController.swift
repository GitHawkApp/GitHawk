//
//  AppSplitViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/6/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

final class AppSplitViewController: UISplitViewController {

    private let tabDelegate = TabBarControllerDelegate()
    private let appSplitViewDelegate = SplitViewControllerDelegate()

    override func viewDidLoad() {
        super.viewDidLoad()
        masterTabBarController?.delegate = tabDelegate
        delegate = appSplitViewDelegate
        preferredDisplayMode = .allVisible
    }

    private var detailNavigationController: UINavigationController? {
        return viewControllers.last as? UINavigationController
    }

    private var masterTabBarController: UITabBarController? {
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
