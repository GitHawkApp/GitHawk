//
//  UIImageView+StoryboardTintFix.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/11/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

// https://stackoverflow.com/a/50135807
extension UIImageView {

    override open func awakeFromNib() {
        super.awakeFromNib()
        tintColorDidChange()
    }

}
