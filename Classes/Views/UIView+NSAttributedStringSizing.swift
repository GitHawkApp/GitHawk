//
//  UIView+NSAttributedStringSizing.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIView {

    func configureAndLayout(_ text: NSAttributedStringSizing) {
        backgroundColor = .white
        isOpaque = true
        layer.contentsGravity = kCAGravityTopLeft
        layer.contentsScale = text.screenScale
        layer.contents = text.contents()
        frame = UIEdgeInsetsInsetRect(CGRect(origin: .zero, size: text.textViewSize), text.inset)
    }

}
