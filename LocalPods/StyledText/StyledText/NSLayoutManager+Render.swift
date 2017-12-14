//
//  NSLayoutManager+Render.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

internal extension NSLayoutManager {

    func size(textContainer: NSTextContainer, width: CGFloat, scale: CGFloat) -> CGSize {
        textContainer.size = CGSize(width: width, height: 0)
        let bounds = usedRect(for: textContainer)
        return bounds.size.snapped(scale: scale)
    }

    func render(
        size: CGSize,
        textContainer: NSTextContainer,
        scale: CGFloat,
        backgroundColor: UIColor? = nil
        ) -> CGImage? {
        textContainer.size = size

        UIGraphicsBeginImageContextWithOptions(size, backgroundColor != nil, scale)
        backgroundColor?.setFill()
        UIBezierPath(rect: CGRect(origin: .zero, size: size)).fill()
        let range = glyphRange(for: textContainer)
        drawBackground(forGlyphRange: range, at: .zero)
        drawGlyphs(forGlyphRange: range, at: .zero)
        let contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()
        return contents
    }

}
