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
        let insets: UIEdgeInsets
        if #available(iOS 11.0, *) {
            insets = safeAreaInsets
        } else {
            insets = .zero
        }
        contentView.frame = UIEdgeInsetsInsetRect(bounds, insets)
    }

}
