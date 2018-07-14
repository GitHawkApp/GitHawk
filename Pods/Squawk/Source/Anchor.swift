//
//  Anchor.swift
//  Squawk
//
//  Created by Ryan Nystrom on 7/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

internal func anchor(view: UIView, referenceView: UIView) -> CGPoint {
    let safeBottom: CGFloat = referenceView.safeAreaInsets.bottom

    let bounds = referenceView.bounds
    let tabBarHeight: CGFloat = 49
    return CGPoint(
        x: bounds.width / 2,
        y: bounds.height - tabBarHeight - safeBottom - view.bounds.height / 2 - 20
    )
}
