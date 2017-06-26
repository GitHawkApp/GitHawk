//
//  NSAttributedStringSizing.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

extension CGSize {

    func snapped(scale: CGFloat) -> CGSize {
        var size = self
        size.width = ceil(size.width * scale) / scale
        size.height = ceil(size.height * scale) / scale
        return size
    }

    func resized(inset: UIEdgeInsets) -> CGSize {
        var size = self
        size.width += inset.left + inset.right
        size.height += inset.top + inset.bottom
        return size
    }

}

final class NSAttributedStringSizing: NSObject, ListDiffable {

    private let textContainer: NSTextContainer
    private let textStorage: NSTextStorage
    private let layoutManager: NSLayoutManager

    let inset: UIEdgeInsets
    let attributedText: NSAttributedString
    let screenScale: CGFloat

    init(
        containerWidth: CGFloat,
        attributedText: NSAttributedString,
        inset: UIEdgeInsets = .zero,
        exclusionPaths: [UIBezierPath] = [],
        maximumNumberOfLines: Int = 0,
        lineFragmentPadding: CGFloat = 0.0,
        allowsNonContiguousLayout: Bool = false,
        hyphenationFactor: CGFloat = 0.0,
        showsInvisibleCharacters: Bool = false,
        showsControlCharacters: Bool = false,
        usesFontLeading: Bool = true,
        screenScale: CGFloat = UIScreen.main.scale
        ) {
        self.attributedText = attributedText
        self.inset = inset
        self.screenScale = screenScale

        textContainer = NSTextContainer()
        textContainer.exclusionPaths = exclusionPaths
        textContainer.maximumNumberOfLines = maximumNumberOfLines
        textContainer.lineFragmentPadding = lineFragmentPadding

        layoutManager = NSLayoutManager()
        layoutManager.allowsNonContiguousLayout = allowsNonContiguousLayout
        layoutManager.hyphenationFactor = hyphenationFactor
        layoutManager.showsInvisibleCharacters = showsInvisibleCharacters
        layoutManager.showsControlCharacters = showsControlCharacters
        layoutManager.usesFontLeading = usesFontLeading
        layoutManager.addTextContainer(textContainer)

        // storage implicitly required to use NSLayoutManager + NSTextContainer and find a size
        textStorage = NSTextStorage(attributedString: attributedText)
        textStorage.addLayoutManager(layoutManager)

        super.init()

        computeSize(containerWidth)
    }

    // MARK: Public API

    private var _textSize = [CGFloat: CGSize]()
    func textSize(_ width: CGFloat) -> CGSize {
        if let cache = _textSize[width] {
            return cache
        }
        return computeSize(width).size
    }

    private var _textViewSize = [CGFloat: CGSize]()
    func textViewSize(_ width: CGFloat) -> CGSize {
        if let cache = _textViewSize[width] {
            return cache
        }
        return computeSize(width).viewSize
    }

    func configure(textView: UITextView) {
        textView.attributedText = attributedText
        textView.contentInset = .zero
        textView.textContainerInset = inset

        let textContainer = textView.textContainer
        textContainer.exclusionPaths = self.textContainer.exclusionPaths
        textContainer.maximumNumberOfLines = self.textContainer.maximumNumberOfLines
        textContainer.lineFragmentPadding = self.textContainer.lineFragmentPadding

        let layoutManager = textView.layoutManager
        layoutManager.allowsNonContiguousLayout = self.layoutManager.allowsNonContiguousLayout
        layoutManager.hyphenationFactor = self.layoutManager.hyphenationFactor
        layoutManager.showsInvisibleCharacters = self.layoutManager.showsInvisibleCharacters
        layoutManager.showsControlCharacters = self.layoutManager.showsControlCharacters
        layoutManager.usesFontLeading = self.layoutManager.usesFontLeading
        layoutManager.addTextContainer(textContainer)
    }

    private var _contents = [CGFloat: CGImage]()
    func contents(_ width: CGFloat) -> CGImage? {
        if let contents = _contents[width] {
            return contents
        }

        let size = textSize(width)

        UIGraphicsBeginImageContextWithOptions(size, true, screenScale)
        UIColor.white.setFill()
        UIBezierPath(rect: CGRect(origin: .zero, size: size)).fill()
        let glyphRange = layoutManager.glyphRange(for: textContainer)
        layoutManager.drawBackground(forGlyphRange: glyphRange, at: .zero)
        layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: .zero)
        let contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()

        _contents[width] = contents

        return contents
    }

    func attributes(point: CGPoint) -> [String: Any]? {
        var fractionDistance: CGFloat = 1.0
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: &fractionDistance)
        if index != NSNotFound, fractionDistance < 1.0 {
            return attributedText.attributes(at: index, effectiveRange: nil)
        }
        return nil
    }

    // MARK: Private API

    @discardableResult
    func computeSize(_ width: CGFloat) -> (size: CGSize, viewSize: CGSize) {
        let insetWidth = width - inset.left - inset.right
        textContainer.size = CGSize(width: insetWidth, height: 0)

        // find the size of the text now that everything is configured
        let bounds = layoutManager.usedRect(for: textContainer)

        // snap to pixel
        let size = bounds.size.snapped(scale: screenScale)
        _textSize[width] = size

        // adjust for the text view inset (contentInset + textContainerInset)
        let viewSize = size.resized(inset: inset)
        _textViewSize[width] = viewSize

        return (size, viewSize)
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return attributedText
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
