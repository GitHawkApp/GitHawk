//
//  CGSize+Utility.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public extension CGSize {

    func snapped(scale: CGFloat) -> CGSize {
        var size = self
        size.width = ceil(size.width * scale) / scale
        size.height = ceil(size.height * scale) / scale
        return size
    }

    func resized(inset: UIEdgeInsets) -> CGSize {
        var size = self
        size.width += inset.left + inset.right
        size.height += inset.top + inset.bottom
        return size
    }

}
