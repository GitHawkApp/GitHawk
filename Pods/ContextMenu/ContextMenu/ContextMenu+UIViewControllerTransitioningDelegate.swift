//
//  ContextMenu+UIViewControllerTransitioningDelegate.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ContextMenu: UIViewControllerTransitioningDelegate {

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let item = self.item else { return nil }
        return ContextMenuDismissing(item: item)
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let item = self.item else { return nil }
        return ContextMenuPresenting(item: item)
    }

    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        guard let item = self.item else { return nil }
        let controller = ContextMenuPresentationController(presentedViewController: presented, presenting: presenting, item: item)
        controller.contextDelegate = self
        return controller
    }

}
