//
//  UICollectionViewLayout+Orientation.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UICollectionViewLayout {

    func invalidateForOrientationChange() {
        // IGListCollectionViewLayout and orientation change dont' play nicely
        // this hack forces the layout to mark itself invalid
        invalidateLayout(with: invalidationContext(forBoundsChange: .zero))
    }

}
