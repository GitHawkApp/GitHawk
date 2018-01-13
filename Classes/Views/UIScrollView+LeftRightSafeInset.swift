//
//  UIScrollView+LeftRightSafeInset.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIScrollView {

    func updateSafeInset(container view: UIView, base inset: UIEdgeInsets) {
        if #available(iOS 11.0, *) {
            let safe = view.safeAreaInsets
            contentInset = UIEdgeInsets(
                top: inset.top,
                left: inset.left + safe.left,
                bottom: inset.bottom,
                right: inset.right + safe.right
            )
        }
    }

}
