//
//  SplitViewControllerDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/25/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class SplitViewControllerDelegate: UISplitViewControllerDelegate {
    
    private func containsSelection(in primaryViewController: UIViewController) -> Bool {
        guard let nav = primaryViewController as? UINavigationController else { return false }
        
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
        return !containsSelection(in: primaryViewController)
    }

}
