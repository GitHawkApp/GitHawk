//
//  UIViewController+AttributedStringViewDelegate.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIViewController: AttributedStringViewDelegate {

    func didTap(view: AttributedStringView, attribute: DetectedMarkdownAttribute) {
        handle(attribute: attribute)
    }

}
