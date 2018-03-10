//
//  CGRect+Area.swift
//  ThingsUI
//
//  Created by Ryan Nystrom on 3/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension CGRect {

    internal func rect(point: CGPoint, xRemainder: Bool, yRemainder: Bool) -> CGRect {
        let xDiv = divided(atDistance: point.x, from: .minXEdge)
        let x = xRemainder ? xDiv.remainder : xDiv.slice
        let yDiv = x.divided(atDistance: point.y, from: .minYEdge)
        return yRemainder ? yDiv.remainder : yDiv.slice
    }

    internal func area(corner: SourceViewCorner) -> CGFloat {
        let frame: CGRect
        switch corner.position {
        case .topLeft:
            frame = rect(point: corner.point, xRemainder: false, yRemainder: false)
        case .topRight:
            frame = rect(point: corner.point, xRemainder: true, yRemainder: false)
        case .bottomLeft:
            frame = rect(point: corner.point, xRemainder: false, yRemainder: true)
        case .bottomRight:
            frame = rect(point: corner.point, xRemainder: true, yRemainder: true)
        }
        return frame.width * frame.height
    }

}
