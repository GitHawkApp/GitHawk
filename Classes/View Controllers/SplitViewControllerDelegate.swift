//
//  SplitViewControllerDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

protocol PrimaryViewController {}

final class SplitViewControllerDelegate: UISplitViewControllerDelegate {
    
    private func containsSelection(in primaryViewController: UIViewController) -> Bool {
        guard let tab = primaryViewController as? UITabBarController,
            let nav = tab.selectedViewController as? UINavigationController else { return false }
        
        if let provider = nav.topViewController as? FeedSelectionProviding {
            return provider.feedContainsSelection
        }
        
        if let nav = nav.topViewController as? UINavigationController,
            let provider = nav.topViewController as? FeedSelectionProviding {
            return provider.feedContainsSelection
        }
        
        return false
    }

    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool {
//        return !containsSelection(in: primaryViewController)

        if let tab = primaryViewController as? UITabBarController,
            let primaryNav = tab.selectedViewController as? UINavigationController,
            let secondaryNav = secondaryViewController as? UINavigationController {
            primaryNav.viewControllers += secondaryNav.viewControllers.filter {
                return ($0 is SplitPlaceholderViewController) == false
            }
        }

        return true
    }

    func splitViewController(_ splitViewController: UISplitViewController, separateSecondaryFrom primaryViewController: UIViewController) -> UIViewController? {
        guard let tab = primaryViewController as? UITabBarController,
            let primaryNav = tab.selectedViewController as? UINavigationController
            else { return nil }

        var primaryVCs = [UIViewController]()
        var detailVCs = [UIViewController]()

        for vc in primaryNav.viewControllers {
            if vc is PrimaryViewController {
                primaryVCs.append(vc)
            } else {
                detailVCs.append(vc)
            }
        }

        primaryNav.viewControllers = primaryVCs

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

    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
        guard let tab = splitViewController.viewControllers.first as? UITabBarController
            else { return false }

        if splitViewController.isCollapsed {
            if let nav = vc as? UINavigationController, let first = nav.viewControllers.first {
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
