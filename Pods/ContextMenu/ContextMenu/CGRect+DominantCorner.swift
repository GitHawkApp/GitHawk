//
//  CGRect+DominantCorner.swift
//  ContextMenu
//
//  Created by Ryan Nystrom on 5/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension CGRect {

    func dominantCorner(in rect: CGRect) -> SourceViewCorner? {
        let corners: [SourceViewCorner] = [
            SourceViewCorner(point: CGPoint(x: rect.minX, y: rect.minY), position: .topLeft),
            SourceViewCorner(point: CGPoint(x: rect.maxX, y: rect.minY), position: .topRight),
            SourceViewCorner(point: CGPoint(x: rect.minX, y: rect.maxY), position: .bottomLeft),
            SourceViewCorner(point: CGPoint(x: rect.maxX, y: rect.maxY), position: .bottomRight),
            ]

        var maxArea: CGFloat = 0
        var maxCorner: SourceViewCorner? = nil
        for corner in corners {
            let area = self.area(corner: corner)
            if area > maxArea {
                maxArea = area
                maxCorner = corner
            }
        }
        return maxCorner
    }

}
