//
//  Anchor.swift
//  Squawk
//
//  Created by Ryan Nystrom on 7/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

private func snap(value: CGFloat, scale: CGFloat) -> CGFloat {
    return (value * scale).rounded() / scale
}

internal func anchor(
    view: UIView,
    referenceView: UIView,
    configuration: Squawk.Configuration
    ) -> CGPoint {
    let safeBottom: CGFloat = referenceView.safeAreaInsets.bottom
    let bounds = referenceView.bounds
    let scale = UIScreen.main.scale
    return CGPoint(
        x: snap(value: bounds.width / 2, scale: scale),
        y: snap(value: bounds.height - safeBottom - configuration.bottomPadding - view.bounds.height / 2, scale: scale)
    )
}
