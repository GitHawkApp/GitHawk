//
//  TextStyle.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public struct TextStyle: Hashable, Equatable {

    public let fontDescriptor: UIFontDescriptor
    public let size: CGFloat
    public let attributes: [NSAttributedStringKey: Any]
    public let minSize: CGFloat
    public let maxSize: CGFloat

    public init(
        fontDescriptor: UIFontDescriptor = UIFont.systemFont(ofSize: 1).fontDescriptor,
        size: CGFloat = UIFont.systemFontSize,
        attributes: [NSAttributedStringKey: Any] = [:],
        minSize: CGFloat = 0,
        maxSize: CGFloat = .greatestFiniteMagnitude
        ) {
        self.fontDescriptor = fontDescriptor
        self.size = size
        self.attributes = attributes
        self.minSize = minSize
        self.maxSize = maxSize

        self._hashValue = fontDescriptor
            .combineHash(with: size)
            .combineHash(with: attributes.count)
            .combineHash(with: minSize)
            .combineHash(with: maxSize)
    }

    public init(
        name: String = UIFont.systemFont(ofSize: 1).fontName,
        size: CGFloat = UIFont.systemFontSize,
        attributes: [NSAttributedStringKey: Any] = [:],
        traits: UIFontDescriptorSymbolicTraits = [],
        minSize: CGFloat = 0,
        maxSize: CGFloat = .greatestFiniteMagnitude
        ) {

        let baseFontDescriptor = UIFontDescriptor()
            .addingAttributes([.name: name])
        let traitFontDescriptor = baseFontDescriptor.withSymbolicTraits(traits)
        if traitFontDescriptor == nil {
            print("WARNING: No font found for name \"\(name)\" with traits \(traits)")
        }
        self.init(
            fontDescriptor: traitFontDescriptor ?? UIFontDescriptor(name: name, size: size),
            size: size,
            attributes: attributes,
            minSize: minSize,
            maxSize: maxSize
        )
    }

    public func font(contentSizeCategory: UIContentSizeCategory) -> UIFont {
        let preferredSize = contentSizeCategory.preferredContentSize(size)
        return UIFont(descriptor: fontDescriptor, size: preferredSize)
    }

    internal let _hashValue: Int
    public var hashValue: Int {
        return _hashValue
    }

    public static func == (lhs: TextStyle, rhs: TextStyle) -> Bool {
        return lhs.size == rhs.size
            && lhs.minSize == rhs.minSize
            && rhs.maxSize == rhs.maxSize
            && lhs.fontDescriptor == rhs.fontDescriptor
            && NSDictionary(dictionary: lhs.attributes).isEqual(to: rhs.attributes)
    }

}

