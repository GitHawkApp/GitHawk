//
//  StyledTextRenderCacheKey.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

struct StyledTextRenderCacheKey: Hashable, Equatable {

    let width: CGFloat
    let attributedText: NSAttributedString

    var hashValue: Int {
        return width
            .combineHash(with: attributedText)
    }

    public static func == (lhs: StyledTextRenderCacheKey, rhs: StyledTextRenderCacheKey) -> Bool {
        return lhs.width == rhs.width
            && lhs.attributedText == rhs.attributedText
    }

}
