//
//  UIScrollView+ScrollToTop.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIScrollView {

    func scrollToTop(animated: Bool) {
        setContentOffset(CGPoint(x: 0, y: -adjustedContentInset.top), animated: animated)
    }

}
