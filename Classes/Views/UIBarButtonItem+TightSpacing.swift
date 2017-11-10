//
//  UIBarButtonItem+Button.swift
//  Freetime
//
//  Created by Joe Rocca on 11/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UIBarButtonItem {
    convenience init(image: UIImage?, target: Any, action: Selector) {
        let button = UIButton(frame: Styles.Sizes.barButton)
        button.setImage(image?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        self.init(customView: button)
    }
}
