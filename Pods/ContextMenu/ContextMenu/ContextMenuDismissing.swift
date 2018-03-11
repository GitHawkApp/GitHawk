//
//  ContextMenuDismissing.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

class ContextMenuDismissing: NSObject, UIViewControllerAnimatedTransitioning {

    private let item: ContextMenu.Item

    init(item: ContextMenu.Item) {
        self.item = item
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return }

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromViewController.view.alpha = 0
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return item.options.durations.dismiss
    }

}
