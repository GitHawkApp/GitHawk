//
//  UIMenuController+Reactions.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIMenuController {

    func showReactions(fromView: UIView) {

        fromView.becomeFirstResponder()

        let reactions: [ReactionType] = [
            .thumbsUp,
            .hooray,
            .thumbsDown,
            .heart,
            .laugh,
            .confused
        ]

        let menu = UIMenuController.shared
        menu.menuItems = reactions.map {
            UIMenuItem(title: $0.rawValue, action: #selector(UIMenuController._empty))
        }
        menu.setTargetRect(fromView.bounds, in: fromView)
        menu.setMenuVisible(true, animated: true)
    }

    func _empty() {}
    
}
