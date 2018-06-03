//
//  UIContentSizeCategory+Scaling.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

internal extension UIContentSizeCategory {

    var multiplier: CGFloat {
        switch self {
        case .accessibilityExtraExtraExtraLarge: return 23 / 16
        case .accessibilityExtraExtraLarge: return 22 / 16
        case .accessibilityExtraLarge: return 21 / 16
        case .accessibilityLarge: return 20 / 16
        case .accessibilityMedium: return 19 / 16
        case .extraExtraExtraLarge: return 19 / 16
        case .extraExtraLarge: return 18 / 16
        case .extraLarge: return 17 / 16
        case .large: return 1
        case .medium: return 15 / 16
        case .small: return 14 / 16
        case .extraSmall: return 13 / 16
        default: return 1
        }
    }

    func preferredContentSize(
        _ base: CGFloat,
        minSize: CGFloat = 0,
        maxSize: CGFloat = CGFloat.greatestFiniteMagnitude
        ) -> CGFloat {
        let result = base * multiplier
        return min(max(result, minSize), maxSize)
    }

}
