//
//  SplitViewControllerDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

// add this shell protocol onto a view controller that should remain part of a tab's root nav VC when splitting out
// detail VCs from primary on split VC expansion
protocol PrimaryViewController {}

final class SplitViewControllerDelegate: UISplitViewControllerDelegate {

    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool {
        if let tab = primaryViewController as? UITabBarController,
            let primaryNav = tab.selectedViewController as? UINavigationController,
            let secondaryNav = secondaryViewController as? UINavigationController {

            // remove any placeholder VCs from the stack
            primaryNav.viewControllers += secondaryNav.viewControllers.filter {
                $0.hidesBottomBarWhenPushed = true
                return ($0 is SplitPlaceholderViewController) == false
            }
        }

        return true
    }

    func splitViewController(
        _ splitViewController: UISplitViewController,
        separateSecondaryFrom primaryViewController: UIViewController
        ) -> UIViewController? {
        guard let tab = primaryViewController as? UITabBarController,
            let primaryNav = tab.selectedViewController as? UINavigationController
            else { return nil }

        var detailVCs = [UIViewController]()

        // for each tab VC that is a nav controller, pluck everything that isn't marked as a primary VC off of
        // the nav stack. if the nav is the currently selected tab VC, then move all non-primary VCs to
        for tabVC in tab.viewControllers ?? [] {
            // they should all be navs, but just in case
            guard let nav = tabVC as? UINavigationController else { continue }

            // pop until hitting a VC marked as "primary"
            while let top = nav.topViewController,
                top !== nav.viewControllers.first,
                (top is PrimaryViewController) == false {
                if nav === primaryNav {
                    detailVCs.insert(top, at: 0)
                }
                nav.popViewController(animated: false)
            }
        }

        if detailVCs.count > 0 {
            // if there are active VCs, push them onto the new nav stack
            let nav = UINavigationController()
            nav.setViewControllers(detailVCs, animated: false)
            return nav
        } else {
            // otherwise use a placeholder VC
            return UINavigationController(rootViewController: SplitPlaceholderViewController())
        }
    }

    func splitViewController(
        _ splitViewController: UISplitViewController,
        showDetail vc: UIViewController,
        sender: Any?
        ) -> Bool {
        guard let tab = splitViewController.viewControllers.first as? UITabBarController
            else { return false }

        if splitViewController.isCollapsed {
            if let nav = vc as? UINavigationController, let first = nav.viewControllers.first {
                // always remove the tab bar when pushing VCs
                first.hidesBottomBarWhenPushed = true
                tab.selectedViewController?.show(first, sender: sender)
            } else {
                tab.selectedViewController?.show(vc, sender: sender)
            }
        } else {
            splitViewController.viewControllers = [tab, vc]
        }

        return true
    }

}
