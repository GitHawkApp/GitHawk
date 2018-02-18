//
//  FixedRefreshControl.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

// https://stackoverflow.com/q/48178076/940936
final class FixedRefreshControl: UIRefreshControl {

    override var frame: CGRect {
        get { return super.frame }
        set {
            var newFrame = newValue
            if let superScrollView = superview as? UIScrollView {
                newFrame.origin.x = superScrollView.frame.minX - superScrollView.contentInset.left
            }
            super.frame = newFrame
        }
    }

}
