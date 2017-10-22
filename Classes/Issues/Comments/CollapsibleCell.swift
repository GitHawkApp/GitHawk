//
//  CollapsibleCell.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/28/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

let CollapseCellMinHeight: CGFloat = 20

func CreateCollapsibleOverlay() -> CALayer {
    let layer = CAGradientLayer()
    layer.isHidden = true
    layer.colors = [
        UIColor(white: 1, alpha: 0).cgColor,
        UIColor(white: 0, alpha: 0.1).cgColor
    ]
    return layer
}

func LayoutCollapsible(layer: CALayer, view: UIView) {
    if layer.superlayer != view.layer {
        view.layer.addSublayer(layer)
    }

    let bounds = view.bounds

    // disable implicit CALayer animations
    CATransaction.begin()
    CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
    layer.frame = CGRect(
        x: 0,
        y: bounds.height - CollapseCellMinHeight,
        width: bounds.width,
        height: CollapseCellMinHeight
    )
    CATransaction.commit()
}

protocol CollapsibleCell {

    func setCollapse(visible: Bool)

}
