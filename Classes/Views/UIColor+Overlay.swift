//
//  UIColor+Overlay.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIColor {

    var textOverlayColor: UIColor? {
        guard let componentColors = cgColor.components else { return nil }
        let brightness = (componentColors[0]*299 + componentColors[1]*587 + componentColors[2]*114) / 1000.0
        return brightness < 0.5 ? .white : .black
    }

}
