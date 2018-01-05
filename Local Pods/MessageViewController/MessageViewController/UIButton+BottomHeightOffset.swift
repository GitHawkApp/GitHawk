//
//  UIButton+InternalSizeOffset.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

internal extension UIButton {

    // the bottom space between the containing UIView and the closest content view (label or image)
    // should call sizeToFit() sometime before using this method
    var bottomHeightOffset: CGFloat {
        let height = bounds.size.height

        // adjust the button so its content is aligned w/ the bottom of the text view
        let titleLabelMaxY: CGFloat
        if let titleBounds = titleLabel?.frame, titleBounds != .zero {
            titleLabelMaxY = titleBounds.maxY
        } else {
            titleLabelMaxY = height
        }

        let imageViewMaxY: CGFloat
        if let imageBounds = imageView?.frame, imageBounds != .zero {
            imageViewMaxY = imageBounds.maxY
        } else {
            imageViewMaxY = height
        }

        return max(height - titleLabelMaxY, height - imageViewMaxY)
    }

}
