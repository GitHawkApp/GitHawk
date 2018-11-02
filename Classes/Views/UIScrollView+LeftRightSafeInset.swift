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
        let safe = view.safeAreaInsets
        contentInset = UIEdgeInsets(
            top: inset.top,
            left: inset.left + safe.left,
            bottom: inset.bottom,
            right: inset.right + safe.right
        )
    }

}
