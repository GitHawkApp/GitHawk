//
//  NSAttributedStringSizing.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit
import StyledText

final class NSAttributedStringSizing: NSObject, ListDiffable {

    private let textContainer: NSTextContainer
    private let textStorage: NSTextStorage
    private let layoutManager: NSLayoutManager

    let inset: UIEdgeInsets
    let attributedText: NSAttributedString
    let screenScale: CGFloat
    let backgroundColor: UIColor

    init(
        containerWidth: CGFloat,
        attributedText: NSAttributedString,
        inset: UIEdgeInsets = .zero,
        backgroundColor: UIColor = .white,
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
        self.backgroundColor = backgroundColor

        textContainer = NSTextContainer()
        textContainer.exclusionPaths = exclusionPaths
        textContainer.maximumNumberOfLines = maximumNumberOfLines
        textContainer.lineFragmentPadding = lineFragmentPadding

        layoutManager = LabelLayoutManager()
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

        computeSize(CacheKey(attributedText: attributedText, width: containerWidth))
    }

    // MARK: Public API

    private struct CacheKey: Hashable, Equatable {
        let attributedText: NSAttributedString
        let width: CGFloat

        var hashValue: Int {
            return attributedText.combineHash(with: width)
        }

    }

    private static let globalSizeCache = LRUCache<CacheKey, CGSize>(
        maxSize: 1000,
        compaction: LRUCache.Compaction.default,
        clearOnWarning: true
    )

    func textSize(_ width: CGFloat) -> CGSize {
        let key = CacheKey(attributedText: attributedText, width: width)
        if let cache = NSAttributedStringSizing.globalSizeCache[key] {
            return cache
        }
        return computeSize(key)
    }

    func textViewSize(_ width: CGFloat) -> CGSize {
        return textSize(width).resized(inset: inset)
    }

    func rect(_ width: CGFloat) -> CGRect {
        let size = textSize(width)
        return CGRect(
            x: inset.left,
            y: inset.top,
            width: size.width - inset.left - inset.right,
            height: size.height - inset.top - inset.bottom
        )
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

    private static let globalBitmapCache = LRUCache<CacheKey, CGImage>(
        maxSize: 1024 * 1024 * 20, // 20mb
        compaction: LRUCache.Compaction.default,
        clearOnWarning: true
    )

    func contents(_ width: CGFloat) -> CGImage? {
        let key = CacheKey(attributedText: attributedText, width: width)

        if let contents = NSAttributedStringSizing.globalBitmapCache[key] {
            return contents
        }

        let size = textSize(width)
        textContainer.size = size

        UIGraphicsBeginImageContextWithOptions(size, true, screenScale)
        backgroundColor.setFill()
        UIBezierPath(rect: CGRect(origin: .zero, size: size)).fill()
        let glyphRange = layoutManager.glyphRange(for: textContainer)
        layoutManager.drawBackground(forGlyphRange: glyphRange, at: .zero)
        layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: .zero)
        let contents = UIGraphicsGetImageFromCurrentImageContext()?.cgImage
        UIGraphicsEndImageContext()

        NSAttributedStringSizing.globalBitmapCache[key] = contents

        return contents
    }

    func attributes(point: CGPoint) -> [NSAttributedStringKey: Any]? {
        var fractionDistance: CGFloat = 1.0
        let index = layoutManager.characterIndex(for: point, in: textContainer, fractionOfDistanceBetweenInsertionPoints: &fractionDistance)
        if index != NSNotFound, fractionDistance < 1.0 {
            return attributedText.attributes(at: index, effectiveRange: nil)
        }
        return nil
    }

    // MARK: Private API

    @discardableResult
    private func computeSize(_ key: CacheKey) -> CGSize {
        let insetWidth = max(key.width - inset.left - inset.right, 0)
        textContainer.size = CGSize(width: insetWidth, height: 0)

        // find the size of the text now that everything is configured
        let bounds = layoutManager.usedRect(for: textContainer)

        // snap to pixel
        let size = bounds.size.snapped(scale: screenScale)
        NSAttributedStringSizing.globalSizeCache[key] = size

        return size
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return attributedText
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}

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
