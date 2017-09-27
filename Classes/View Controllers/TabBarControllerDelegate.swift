//
//  TabBarControllerDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class TabBarControllerDelegate: NSObject, UITabBarControllerDelegate {

    private var tapCount = 0
    private weak var previousSelectedViewController: UIViewController? = nil

    func tabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController
        ) {
        // will be nil on first start
        let tabDidNotChange = previousSelectedViewController == nil
        || previousSelectedViewController == viewController

        // confirm at root VC
        if tabBarController.selectedViewController == viewController,
            let nav = viewController as? UINavigationController,
            // don't handle taps when the nav is popping
            nav.transitionCoordinator?.viewController(forKey: UITransitionContextViewControllerKey.from) == nil,
            let root = nav.viewControllers.first as? TabNavRootViewControllerType {
            tapCount += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.17, execute: {
                let count = self.tapCount

                // make sure that on the same VC that queued the tap-check
                if tabBarController.selectedViewController == viewController {
                    if count == 1 && tabDidNotChange {
                        root.didSingleTapTab()
                    } else if count > 1 {
                        root.didDoubleTapTab()
                    }
                }

                self.resetTaps()
            })
        } else {
            resetTaps()
        }

        previousSelectedViewController = viewController
    }

    func resetTaps() {
        tapCount = 0
    }

}
