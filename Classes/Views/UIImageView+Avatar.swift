//
//  UIImageView+Avatar.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIImageView {

    func configureForAvatar(border: Bool = true) {
        contentMode = .scaleAspectFill
        backgroundColor = Styles.Colors.Gray.lighter.color
        layer.cornerRadius = Styles.Sizes.avatarCornerRadius
        if border {
            layer.borderColor = Styles.Colors.Gray.light.color.cgColor
            layer.borderWidth = 1.0 / UIScreen.main.scale
        }
        clipsToBounds = true
    }

}
