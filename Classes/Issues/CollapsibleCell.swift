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
    layer.colors = [
        UIColor.clear.cgColor,
        UIColor.white.cgColor
    ]
    layer.startPoint = .zero
    layer.endPoint = CGPoint(x: 0, y: CollapseCellMinHeight)
    return layer
}

func LayoutCollapsible(layer: CALayer, view: UIView) {
    let bounds = view.bounds
    layer.frame = CGRect(
        x: 0,
        y: bounds.height - CollapseCellMinHeight,
        width: bounds.width,
        height: CollapseCellMinHeight
    )
}

protocol CollapsibleCell {

    func setCollapse(hidden: Bool)

}
