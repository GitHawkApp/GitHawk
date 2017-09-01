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
        if let tab = primaryViewController as? UITabBarController,
            let primaryNav = tab.selectedViewController as? UINavigationController,
            let secondaryNav = secondaryViewController as? UINavigationController {

            // remove any placeholder VCs from the stack
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

        var detailVCs = [UIViewController]()

        // for each tab VC that is a nav controller, pluck everything that isn't marked as a primary VC off of
        // the nav stack. if the nav is the currently selected tab VC, then move all non-primary VCs to
        for tabVC in tab.viewControllers ?? [] {
            // they should all be navs, but just in case
            guard let nav = tabVC as? UINavigationController else { continue }

            var primaryVCs = [UIViewController]()
            for vc in nav.viewControllers {
                if vc is PrimaryViewController {
                    primaryVCs.append(vc)
                } else if nav === primaryNav {
                    // collect selected tab, non-primary VCs
                    detailVCs.append(vc)
                }
            }
            nav.viewControllers = primaryVCs
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

    func splitViewController(_ splitViewController: UISplitViewController, showDetail vc: UIViewController, sender: Any?) -> Bool {
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
