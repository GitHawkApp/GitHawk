//
//  UIActivityController+TintColor.swift
//  Freetime
//
//  Created by Ehud Adler on 10/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {

    enum ActivityIndicatorStyle {
        case white
        case gray
        case basedOnBackground
    }

    func startAnimatingWith(style: ActivityIndicatorStyle) {

        func setLight() {
            activityIndicatorViewStyle = .white
        }

        func setDark() {
            activityIndicatorViewStyle = .gray
        }

        switch style {
        case .white:
            activityIndicatorViewStyle = .white
        case .gray:
            activityIndicatorViewStyle = .gray
        default:
            guard let superview = self.superview,
                let bgColor = superview.backgroundColor,
                let rgbColors = bgColor.cgColor.components else {
                    self.startAnimating()
                    return

            }
            // Check for white/black which are 2 components
            if rgbColors.count == 2 {
                return rgbColors[0] == 1 ?  setDark() : setLight()
            }

            let darkLightLevel = ((rgbColors[0] * 299) + (rgbColors[1] * 587) + (rgbColors[2] * 114)) / 1000

            darkLightLevel > 125 ? setDark() : setLight()
        }
        self.startAnimating()
    }
}
