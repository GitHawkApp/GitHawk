//
//  UIView+AutoLayout.swift
//  Pageboy
//
//  Created by Merrick Sapsford on 15/02/2017.
//  Copyright © 2018 UI At Six. All rights reserved.
//

import UIKit

internal extension UIView {
    
    @discardableResult func pinToSuperviewEdges() -> [NSLayoutConstraint]? {
        guard self.superview != nil else {
            fatalError("superview can not be nil")
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let views = ["view": self]
        var constraints = [NSLayoutConstraint]()
        let xConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(),
                                                          metrics: nil, views: views)
        let yConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                          options: NSLayoutFormatOptions(),
                                                          metrics: nil, views: views)
        constraints.append(contentsOf: xConstraints)
        constraints.append(contentsOf: yConstraints)
        
        self.superview?.addConstraints(constraints)
        
        return constraints
    }
}
