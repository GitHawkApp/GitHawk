//
//  SplitViewControllerDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SplitViewControllerDelegate: UISplitViewControllerDelegate {

    func splitViewController(
        _ splitViewController: UISplitViewController,
        collapseSecondary secondaryViewController: UIViewController,
        onto primaryViewController: UIViewController
        ) -> Bool {
        // use an empty class to detect if displaying a placeholder VC as details
        if let nav = secondaryViewController as? UINavigationController,
            nav.viewControllers.first is SplitPlaceholderViewController {
            return true
        }
        return false
    }

}
