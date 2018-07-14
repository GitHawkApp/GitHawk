//
//  RubberBandDistance.swift
//  Squawk
//
//  Created by Ryan Nystrom on 7/14/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

internal func rubberBandDistance(offset: CGFloat, dimension: CGFloat) -> CGFloat {
    let constant: CGFloat = 0.55
    let absOffset = abs(offset)
    let result = (constant * absOffset * dimension) / (dimension + constant * absOffset)
    return offset < 0 ? -result : result
}
