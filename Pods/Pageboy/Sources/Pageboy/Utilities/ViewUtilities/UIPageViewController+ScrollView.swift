//
//  UIPageViewController+ScrollView.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 13/02/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import UIKit

internal extension UIPageViewController {
    
    var scrollView: UIScrollView? {
        get {
            for subview in self.view.subviews {
                if let scrollView = subview as? UIScrollView {
                    return scrollView
                }
            }
            return nil
        }
    }
}
