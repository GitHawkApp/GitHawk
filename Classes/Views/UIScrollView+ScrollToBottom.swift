//
//  UIScrollView+ScrollToBottom.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIScrollView {

    func scrollToBottom(animated: Bool) {
        let inset = contentInset
        let contentHeight = contentSize.height
        let viewportHeight = bounds.height
        let offset = contentHeight - inset.bottom + inset.top - viewportHeight
        setContentOffset(CGPoint(x: 0, y: offset), animated: animated)
    }

}
