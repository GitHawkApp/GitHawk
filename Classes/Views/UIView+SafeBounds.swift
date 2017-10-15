//
//  UIView+SafeBounds.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIView {

    var safeBounds: CGRect {
        let safeInsets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            safeInsets = safeAreaInsets
        } else {
            safeInsets = .zero
        }
        return UIEdgeInsetsInsetRect(bounds, safeInsets)
    }

}
