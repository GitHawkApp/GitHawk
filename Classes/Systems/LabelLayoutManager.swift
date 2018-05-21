//
//  LabelLayoutManager.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

final class LabelLayoutManager: NSLayoutManager {

    override func fillBackgroundRectArray(_ rectArray: UnsafePointer<CGRect>, count rectCount: Int, forCharacterRange charRange: NSRange, color: UIColor) {

        // Get the attributes for the backgroundColor attribute
        var range = charRange
        let attributes = textStorage?.attributes(at: charRange.location, effectiveRange: &range)

        // Ensure that this is one of our labels we're dealing with, ignore basic backgroundColor attributes
        guard attributes?[MarkdownAttribute.label] != nil else {
            super.fillBackgroundRectArray(rectArray, count: rectCount, forCharacterRange: charRange, color: color)
            return
        }

        let rawRect = rectArray[0]
        let rect = CGRect(
            x: floor(rawRect.origin.x),
            y: floor(rawRect.origin.y),
            width: floor(rawRect.size.width),
            height: floor(rawRect.size.height)
            ).insetBy(dx: -3, dy: 0)
        UIBezierPath(roundedRect: rect, cornerRadius: Styles.Sizes.labelCornerRadius).fill()
    }

}
