//
//  UIScrollView+ScrollToTop.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 9/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIScrollView {

    func scrollToTop(animated: Bool) {
        let topInset: CGFloat
        if #available(iOS 11.0, *) {
            topInset = adjustedContentInset.top
        } else {
            topInset = contentInset.top
        }
        setContentOffset(CGPoint(x: 0, y: -topInset), animated: animated)
    }

}
