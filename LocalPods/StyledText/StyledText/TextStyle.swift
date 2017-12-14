//
//  TextStyle.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public struct TextStyle: Hashable, Equatable {

    public let name: String
    public let size: CGFloat
    public let attributes: [NSAttributedStringKey: AnyObject]
    public let traits: UIFontDescriptorSymbolicTraits
    public let minSize: CGFloat
    public let maxSize: CGFloat

    init(
        name: String = UIFont.systemFont(ofSize: 1).fontName,
        size: CGFloat = UIFont.systemFontSize,
        attributes: [NSAttributedStringKey: AnyObject] = [:],
        traits: UIFontDescriptorSymbolicTraits = [],
        minSize: CGFloat = 0,
        maxSize: CGFloat = .greatestFiniteMagnitude
        ) {
        self.name = name
        self.size = size
        self.attributes = attributes
        self.traits = traits
        self.minSize = minSize
        self.maxSize = maxSize

        self._hashValue = name
            .combineHash(with: size)
            .combineHash(with: attributes.count)
            .combineHash(with: traits.rawValue)
            .combineHash(with: minSize)
            .combineHash(with: maxSize)
    }

    public func font(contentSizeCategory: UIContentSizeCategory) -> UIFont {
        let preferredSize = contentSizeCategory.preferredContentSize(size)
        let font = UIFont(name: name, size: preferredSize) ?? UIFont.systemFont(ofSize: preferredSize)
        return font.addingTraits(traits: traits)
    }

    internal let _hashValue: Int
    public var hashValue: Int {
        return _hashValue
    }

    public static func == (lhs: TextStyle, rhs: TextStyle) -> Bool {
        return lhs.size == rhs.size
            && lhs.traits == rhs.traits
            && lhs.minSize == rhs.minSize
            && rhs.maxSize == rhs.maxSize
            && lhs.name == rhs.name
            && NSDictionary(dictionary: lhs.attributes).isEqual(to: rhs.attributes)
    }

}

