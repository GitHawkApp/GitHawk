//
//  UIScrollView+ScrollActivity.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 23/01/2018.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal extension UIScrollView {
    
    /// Whether the scroll view can be assumed to be interactively scrolling
    var isProbablyActiveInScroll: Bool {
        return self.isTracking || self.isDragging || self.isDecelerating
    }
}
