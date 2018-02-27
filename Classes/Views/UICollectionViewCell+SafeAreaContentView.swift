//
//  UICollectionViewCell+SafeAreaContentView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/16/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    func layoutContentViewForSafeAreaInsets() {
        layoutContentViewForSafeAreaInsets(bounds: self.bounds)
    }

    func layoutContentViewForSafeAreaInsets(bounds: CGRect) {
        let insets: UIEdgeInsets = safeAreaInsets
        contentView.frame = CGRect(
            x: insets.left,
            y: bounds.minY,
            width: bounds.width - insets.left - insets.right,
            height: bounds.height
        )
    }

}
