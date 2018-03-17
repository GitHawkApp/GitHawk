//
//  StyledTextRenderer.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public final class StyledTextRenderer {

    private let layoutManager: NSLayoutManager
    private let textContainer: NSTextContainer
    
    public let scale: CGFloat
    public let inset: UIEdgeInsets
    public let string: StyledTextString
    public let backgroundColor: UIColor?

    private var map = [UIContentSizeCategory: NSTextStorage]()
    private var lock = os_unfair_lock_s()

    public init(
        string: StyledTextString,
        inset: UIEdgeInsets = .zero,
        backgroundColor: UIColor? = nil,
        layoutManager: NSLayoutManager = NSLayoutManager(),
        scale: CGFloat = StyledTextScreenScale
        ) {
        self.string = string
        self.inset = inset
        self.backgroundColor = backgroundColor
        self.scale = scale

        textContainer = NSTextContainer()
        textContainer.exclusionPaths = []
        textContainer.maximumNumberOfLines = 0
        textContainer.lineFragmentPadding = 0

        self.layoutManager = layoutManager
        layoutManager.allowsNonContiguousLayout = false
        layoutManager.hyphenationFactor = 0
        layoutManager.showsInvisibleCharacters = false
        layoutManager.showsControlCharacters = false
        layoutManager.usesFontLeading = true
        layoutManager.addTextContainer(textContainer)
    }

    private func storage(contentSizeCategory: UIContentSizeCategory) -> NSTextStorage {
        if let storage = map[contentSizeCategory] {
            return storage
        }
        let storage = NSTextStorage(attributedString: string.render(contentSizeCategory: contentSizeCategory))
        storage.addLayoutManager(layoutManager)
        map[contentSizeCategory] = storage
        return storage
    }

    private static let globalSizeCache = LRUCache<StyledTextRenderCacheKey, CGSize>(
        maxSize: 1000, // CGSize cache size always 1, treat as item count
        compaction: .default,
        clearOnWarning: true
    )

    // not thread safe
    private func _size(_ key: StyledTextRenderCacheKey) -> CGSize {
        let cache = StyledTextRenderer.globalSizeCache
        if let cached = cache[key] {
            return cached
        }
        let insetWidth = max(key.width - inset.left - inset.right, 0)
        let size = layoutManager.size(textContainer: textContainer, width: insetWidth, scale: scale)
        cache[key] = size
        return size
    }

    public func size(
        contentSizeCategory: UIContentSizeCategory = .large,
        width: CGFloat
        ) -> CGSize {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }
        let attributedText = storage(contentSizeCategory: contentSizeCategory)
        return _size(StyledTextRenderCacheKey(width: width, attributedText: attributedText))
    }

    static let globalBitmapCache = LRUCache<StyledTextRenderCacheKey, CGImage>(
        maxSize: 1024 * 1024 * 20, // 20mb
        compaction: .default,
        clearOnWarning: true
    )

    public func render(
        contentSizeCategory: UIContentSizeCategory = .large,
        width: CGFloat
        ) -> (image: CGImage?, size: CGSize) {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }

        let attributedText = storage(contentSizeCategory: contentSizeCategory)
        let key = StyledTextRenderCacheKey(width: width, attributedText: attributedText)
        let size = _size(key)
        let cache = StyledTextRenderer.globalBitmapCache
        if let cached = cache[key] {
            return (cached, size)
        }

        let contents = layoutManager.render(
            size: size,
            textContainer: textContainer,
            scale: scale,
            backgroundColor: backgroundColor
        )
        cache[key] = contents
        return (contents, size)
    }

    public func attributes(at point: CGPoint) -> [NSAttributedStringKey: Any]? {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }
        var fractionDistance: CGFloat = 1.0
        let index = layoutManager.characterIndex(
            for: point,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: &fractionDistance
        )
        if index != NSNotFound, fractionDistance < 1.0 {
            return layoutManager.textStorage?.attributes(at: index, effectiveRange: nil)
        }
        return nil
    }

    public enum WarmOption {
        case size
        case bitmap
    }

    public func warm(
        _ option: WarmOption = .size,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat
        ) -> StyledTextRenderer {
        switch option {
        case .size: let _ = size(contentSizeCategory: contentSizeCategory, width: width)
        case .bitmap: let _ = render(contentSizeCategory: contentSizeCategory, width: width)
        }
        return self
    }

}
