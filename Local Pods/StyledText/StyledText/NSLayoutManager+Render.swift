//
//  NSLayoutManager+Render.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

private let screenScale = UIScreen.main.scale

extension NSLayoutManager {

    func size(textContainer: NSTextContainer, width: CGFloat, inset: UIEdgeInsets) -> CGSize {
        let insetWidth = max(width - inset.left - inset.right, 0)
        textContainer.size = CGSize(width: insetWidth, height: 0)

        // find the size of the text now that everything is configured
        let bounds = usedRect(for: textContainer)

        // snap to pixel
        return bounds.size.snapped(scale: screenScale)
    }

    func attributes(textContainer: NSTextContainer, attributedText: NSAttributedString, point: CGPoint) -> [NSAttributedStringKey: Any]? {
        var fractionDistance: CGFloat = 1.0
        let index = characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: &fractionDistance)
        if index != NSNotFound, fractionDistance < 1.0 {
            return attributedText.attributes(at: index, effectiveRange: nil)
        }
        return nil
    }

    func render(textContainer: NSTextContainer, backgroundColor: UIColor? = nil) -> CGImage? {
        UIGraphicsBeginImageContextWithOptions(textContainer.size, backgroundColor != nil, screenScale)
        backgroundColor?.setFill()
        UIBezierPath(rect: CGRect(origin: .zero, size: textContainer.size)).fill()
        let range = glyphRange(for: textContainer)
        drawBackground(forGlyphRange: range, at: .zero)
        drawGlyphs(forGlyphRange: range, at: .zero)
        let contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()
        return contents
    }

}
