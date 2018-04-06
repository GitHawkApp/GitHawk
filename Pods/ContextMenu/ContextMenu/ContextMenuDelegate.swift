//
//  ContextMenuDelegate.swift
//  ContextMenu
//
//  Created by Ryan Nystrom on 3/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

public protocol ContextMenuDelegate: class {
    func contextMenuWillDismiss(viewController: UIViewController, animated: Bool)
    func contextMenuDidDismiss(viewController: UIViewController, animated: Bool)
}
