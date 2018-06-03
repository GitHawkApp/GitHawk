//
//  CGImage+LRUCachable.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension CGImage: LRUCachable {

    public var cachedSize: Int {
        return height * bytesPerRow
    }

}
