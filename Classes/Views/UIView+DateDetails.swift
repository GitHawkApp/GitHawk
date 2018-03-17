//
//  UIView+DateDetails.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/17/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIView {

    @objc func showDetailsInMenu(details: String, point: CGPoint) {
        becomeFirstResponder()
        let menu = UIMenuController.shared
        menu.menuItems = [
            UIMenuItem(title: details, action: #selector(UIView.__empty))
        ]
        menu.setTargetRect(CGRect(origin: point, size: CGSize(width: 1, height: 1)), in: self)
        menu.setMenuVisible(true, animated: trueUnlessReduceMotionEnabled)
    }

    @objc private func __empty() {}

}
