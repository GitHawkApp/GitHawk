//
//  ViewControllerTestUtil.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/24/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
import UIKit

extension UIView {
    func subviews(with identifier: String) -> [UIView] {
        var hits = [UIView]()
        for subview in subviews {
            if subview.accessibilityIdentifier == identifier,
                subview.isHidden == false {
                hits.append(subview)
            }
            hits += subview.subviews(with: identifier)
        }
        return hits
    }
}

// https://albertodebortoli.com/2018/03/12/easy-view-controller-unit-testing/
class ViewControllerTestUtil<T: UIViewController> {

    let viewController: T
    private var rootWindow: UIWindow?

    init(viewController: T) {
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        rootWindow?.isHidden = false
        rootWindow?.layer.speed = 100
        rootWindow?.rootViewController = viewController
        _ = viewController.view
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
        viewController.view.setNeedsLayout()
        viewController.view.layoutIfNeeded()
        self.viewController = viewController
    }

    func view(with identifier: String) -> UIView? {
        return viewController.view.subviews(with: identifier).first
    }

    func views(with identifier: String) -> [UIView] {
        return viewController.view.subviews(with: identifier)
    }

}
