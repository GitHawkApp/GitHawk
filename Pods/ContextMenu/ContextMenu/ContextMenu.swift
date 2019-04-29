//
//  ContextMenu.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

/// The interface for displaying context menus, typically interacted with via the `ContextMenu.shared` object.
public class ContextMenu: NSObject {

    /// A singleton controller global context menus.
    public static let shared = ContextMenu()

    var item: Item?

    private override init() {}

    /// Show a context menu from a view controller with given options.
    ///
    /// - Parameters:
    ///   - sourceViewController: The view controller to present from
    ///   - viewController: A content view controller to use inside the menu.
    ///   - options: Display and behavior options for a menu.
    ///   - sourceView: A source view for menu context. If nil, menu displays from the center of the screen.
    ///   - delegate: A delegate the receives events when the menu changes.
    public func show(
        sourceViewController: UIViewController,
        viewController: UIViewController,
        options: Options = Options(),
        sourceView: UIView? = nil,
        delegate: ContextMenuDelegate? = nil
        ) {
        if let previous = self.item {
            previous.viewController.dismiss(animated: false)
        }

        if #available(iOS 10, *), let raw = options.hapticsStyle?.rawValue, let feedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle(rawValue: raw) {
            let haptics = UIImpactFeedbackGenerator(style: feedbackStyle)
            haptics.impactOccurred()
        }

        let item = Item(
            viewController: viewController,
            options: options,
            sourceView: sourceView,
            delegate: delegate
        )
        self.item = item

        item.viewController.transitioningDelegate = self
        item.viewController.modalPresentationStyle = .custom
        item.viewController.modalPresentationCapturesStatusBarAppearance = true
        sourceViewController.present(item.viewController, animated: true)
    }

}
