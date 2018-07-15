//
//  UIViewController+Extensions.swift
//  ContextMenu
//
//  Created by Wes Wickwire on 3/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit


extension UIViewController {
    
    /// Show a context menu with given options.
    ///
    /// - Parameters:
    ///   - viewController: A content view controller to use inside the menu.
    ///   - options: Display and behavior options for a menu.
    ///   - sourceView: A source view for menu context. If nil, menu displays from the center of the screen.
    ///   - delegate: A delegate the receives events when the menu changes.
    public func showContextualMenu(
        _ viewController: UIViewController,
        options: ContextMenu.Options = ContextMenu.Options(),
        sourceView: UIView? = nil,
        delegate: ContextMenuDelegate? = nil
        ) {
        
        ContextMenu.shared.show(
            sourceViewController: self,
            viewController: viewController,
            options: options,
            sourceView: sourceView,
            delegate: delegate
        )
    }
}
