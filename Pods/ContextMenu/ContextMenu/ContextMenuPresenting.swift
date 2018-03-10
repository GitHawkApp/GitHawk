//
//  ContextMenuPresenting.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

internal class ContextMenuPresenting: NSObject, UIViewControllerAnimatedTransitioning {

    private let item: ContextMenu.Item

    init(item: ContextMenu.Item) {
        self.item = item
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return }

        let containerView = transitionContext.containerView

        containerView.addSubview(toViewController.view)

        toViewController.view.alpha = 0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            toViewController.view.alpha = 1
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }

    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return item.options.durations.present
    }

}
