//
//  UIViewController+MessageAutocompleteControllerLayoutDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import MessageViewController

extension UIViewController: MessageAutocompleteControllerLayoutDelegate {

    public func needsLayout(controller: MessageAutocompleteController) {
        controller.layout(in: view)
    }

}
