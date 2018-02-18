//
//  UIScrollView+ScrollToBottom.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIScrollView {

    func scrollToBottom(animated: Bool) {
        let contentHeight = contentSize.height
        let viewportHeight = bounds.height

        // make sure not already at the top
        guard contentHeight > viewportHeight else { return }

        let inset = contentInset
        let offset = contentHeight + inset.bottom - viewportHeight
        setContentOffset(CGPoint(x: contentOffset.x, y: offset), animated: animated)
    }

}
