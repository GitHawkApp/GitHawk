//
//  HittableButton.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

class HittableButton: UIButton {

    var minimumHitSize = CGSize(width: 44, height: 44)

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        var minBounds = bounds
        if bounds.width < minimumHitSize.width {
            minBounds.origin.x -= (minimumHitSize.width - bounds.width) / 2
            minBounds.size.width = minimumHitSize.width
        }
        if bounds.height < minimumHitSize.height {
            minBounds.origin.y -= (minimumHitSize.height - bounds.height) / 2
            minBounds.size.height = minimumHitSize.height
        }
        return minBounds.contains(point) ? self : nil
    }

}
