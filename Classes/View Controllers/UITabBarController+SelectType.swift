//
//  UITabBarController+SelectType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UITabBarController {

    @discardableResult
    func selectTab<T: UIViewController>(of type: T.Type) -> T? {
        for viewController in viewControllers ?? [] {
            let checkController: T?
            let selectController: UIViewController
            if let navigationController = viewController as? UINavigationController,
                let topController = navigationController.topViewController {
                checkController = topController as? T
                selectController = navigationController
            } else {
                checkController = viewController as? T
                selectController = viewController
            }
            if checkController != nil {
                selectedViewController = selectController
                return checkController
            }
        }
        return nil
    }

}
