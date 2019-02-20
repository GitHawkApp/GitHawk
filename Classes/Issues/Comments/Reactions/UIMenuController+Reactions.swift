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

        let reactions: [ReactionContent] = [
            .thumbsUp,
            .hooray,
            .thumbsDown,
            .heart,
            .laugh,
            .confused,
            .rocket,
            .eyes
        ]

        menuItems = reactions.map {
            UIMenuItem(title: $0.rawValue, action: #selector(UIMenuController._empty))
        }
        setTargetRect(fromView.bounds, in: fromView)
        setMenuVisible(true, animated: trueUnlessReduceMotionEnabled)
    }

    @objc func _empty() {}

}
