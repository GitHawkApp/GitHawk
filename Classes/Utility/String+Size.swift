//
//  String+Size.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/26/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension String {

    func size(
        font: UIFont,
        xPadding: CGFloat = 0,
        yPadding: CGFloat = 0
        ) -> CGSize {
        return (self as NSString).size(withAttributes: [
            .font: font
            ]).resized(inset: UIEdgeInsets(
                top: yPadding,
                left: xPadding,
                bottom: yPadding,
                right: xPadding
                )
        )
    }

}
