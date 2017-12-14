//
//  StyledTextRenderer.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class StyledTextRenderer {

    private let builder: StyledTextBuilder
    private let inset: UIEdgeInsets
    private let backgroundColor: UIColor?
    private let layoutManager: NSLayoutManager
    private let textContainer: NSTextContainer

    private var map = [UIContentSizeCategory: NSTextStorage]()
    private var lock = os_unfair_lock_s()

    init(
        builder: StyledTextBuilder,
        inset: UIEdgeInsets = .zero,
        backgroundColor: UIColor? = nil,
        layoutManager: NSLayoutManager = NSLayoutManager()
        ) {
        self.builder = builder
        self.inset = inset
        self.backgroundColor = backgroundColor

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
        let storage = NSTextStorage(attributedString: builder.render(contentSizeCategory: contentSizeCategory))
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
        let size = layoutManager.size(textContainer: textContainer, width: insetWidth)
        cache[key] = size
        return size
    }

    public func size(
        contentSizeCategory: UIContentSizeCategory = UIApplication.shared.preferredContentSizeCategory,
        width: CGFloat
        ) -> CGSize {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }
        let attributedText = storage(contentSizeCategory: contentSizeCategory)
        return _size(StyledTextRenderCacheKey(width: width, attributedText: attributedText))
    }

    static let globalBitmapCache = LRUCache<StyledTextRenderCacheKey, CGImage>(
        maxSize: 1024 * 1024 * 1024 * 20, // 20mb
        compaction: .default,
        clearOnWarning: true
    )

    public func render(
        contentSizeCategory: UIContentSizeCategory = UIApplication.shared.preferredContentSizeCategory,
        width: CGFloat
        ) -> CGImage? {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }

        let attributedText = storage(contentSizeCategory: contentSizeCategory)
        let key = StyledTextRenderCacheKey(width: width, attributedText: attributedText)
        let cache = StyledTextRenderer.globalBitmapCache
        if let cached = cache[key] {
            return cached
        }

        let contents = layoutManager.render(
            size: _size(key),
            textContainer: textContainer,
            backgroundColor: backgroundColor
        )
        cache[key] = contents
        return contents
    }

}
