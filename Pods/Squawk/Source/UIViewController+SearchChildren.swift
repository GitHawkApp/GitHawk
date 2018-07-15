//
//  UIViewController+SearchChildren.swift
//  Pods-Examples
//
//  Created by Ryan Nystrom on 7/15/18.
//

import UIKit

extension UIViewController {

    var topMostChild: UIViewController? {
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.topMostChild
        } else if let nav = self as? UINavigationController {
            return nav.topViewController?.topMostChild
        } else if let split = self as? UISplitViewController {
            return split.viewControllers.last?.topMostChild
        } else if let presented = presentedViewController {
            return presented.topMostChild
        }
        return self
    }

}
