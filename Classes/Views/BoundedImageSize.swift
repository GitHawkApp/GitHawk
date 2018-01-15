//
//  BoundedImageSize.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/9/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func BoundedImageSize(originalSize: CGSize, containerWidth: CGFloat) -> CGSize {
    guard originalSize.width > containerWidth else { return originalSize }
    let ratio = originalSize.width / originalSize.height
    return CGSize(width: containerWidth, height: min(ceil(containerWidth / ratio), 300))
}
