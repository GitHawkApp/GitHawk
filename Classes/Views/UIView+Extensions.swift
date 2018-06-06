//
//  UIView+Extensions.swift
//  Freetime
//
//  Created by Joan Disho on 06.06.18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UIView {

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
}
