//
//  File.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension ContextMenu {

    internal class Item {

        let options: Options
        let viewController: ClippedContainerViewController

        weak var sourceView: UIView?

        init(
            viewController: UIViewController,
            options: Options,
            sourceView: UIView?
            ) {
            self.viewController = ClippedContainerViewController(options: options, viewController: viewController)
            self.options = options
            self.sourceView = sourceView
        }
    }

}
