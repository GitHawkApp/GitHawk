//
//  StyledTextKitBuilder.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import UIKit

public final class StyledTextBuilder: Hashable, Equatable {

    internal var styledTexts: [StyledText]
    internal var savedStyles = [TextStyle]()

    public convenience init(styledText: StyledText) {
        self.init(styledTexts: [styledText])
    }

    public convenience init(text: String) {
        self.init(styledText: StyledText(storage: .text(text)))
    }

    public convenience init(attributedText: NSAttributedString) {
        self.init(styledText: StyledText(storage: .attributedText(attributedText)))
    }

    public init(styledTexts: [StyledText]) {
        self.styledTexts = styledTexts
    }

    public var tipAttributes: [NSAttributedStringKey: Any]? {
        return styledTexts.last?.style.attributes
    }

    public var count: Int {
        return styledTexts.count
    }

    @discardableResult
    public func save() -> StyledTextBuilder {
        if let last = styledTexts.last?.style {
            savedStyles.append(last)
        }
        return self
    }

    @discardableResult
    public func restore() -> StyledTextBuilder {
        guard let last = savedStyles.last else { return self }
        savedStyles.removeLast()
        return add(styledText: StyledText(style: last))
    }

    @discardableResult
    public func add(styledTexts: [StyledText]) -> StyledTextBuilder {
        self.styledTexts += styledTexts
        return self
    }

    @discardableResult
    public func add(styledText: StyledText) -> StyledTextBuilder {
        return add(styledTexts: [styledText])
    }

    @discardableResult
    public func add(style: TextStyle) -> StyledTextBuilder {
        return add(styledText: StyledText(style: style))
    }

    @discardableResult
    public func add(
        text: String,
        traits: UIFontDescriptorSymbolicTraits? = nil,
        attributes: [NSAttributedStringKey: Any]? = nil
        ) -> StyledTextBuilder {
        return add(storage: .text(text), traits: traits, attributes: attributes)
    }

    @discardableResult
    public func add(
        attributedText: NSAttributedString,
        traits: UIFontDescriptorSymbolicTraits? = nil,
        attributes: [NSAttributedStringKey: Any]? = nil
        ) -> StyledTextBuilder {
        return add(storage: .attributedText(attributedText), traits: traits, attributes: attributes)
    }

    @discardableResult
    public func add(
        storage: StyledText.Storage = .text(""),
        traits: UIFontDescriptorSymbolicTraits? = nil,
        attributes: [NSAttributedStringKey: Any]? = nil
        ) -> StyledTextBuilder {
        guard let tip = styledTexts.last else { return self }

        var nextAttributes = tip.style.attributes
        if let attributes = attributes {
            for (k, v) in attributes {
                nextAttributes[k] = v
            }
        }

        let nextStyle: TextStyle
        if let traits = traits {

            let tipFontDescriptor: UIFontDescriptor
            switch tip.style.font {
            case .descriptor(let descriptor): tipFontDescriptor = descriptor
            default: tipFontDescriptor = tip.style.font(contentSizeCategory: .medium).fontDescriptor
            }

            nextStyle = TextStyle(
                font: .descriptor(tipFontDescriptor.withSymbolicTraits(traits) ?? tipFontDescriptor),
                size: tip.style.size,
                attributes: nextAttributes,
                minSize: tip.style.minSize,
                maxSize: tip.style.maxSize
            )
        } else {
            nextStyle = TextStyle(
                font: tip.style.font,
                size: tip.style.size,
                attributes: nextAttributes,
                minSize: tip.style.minSize,
                maxSize: tip.style.maxSize
            )
        }

        return add(styledText: StyledText(storage: storage, style: nextStyle))
    }

    @discardableResult
    public func clearText() -> StyledTextBuilder {
        guard let tipStyle = styledTexts.last?.style else { return self }
        styledTexts.removeAll()
        return add(styledText: StyledText(style: tipStyle))
    }

    public func build(renderMode: StyledTextString.RenderMode = .trimWhitespaceAndNewlines) -> StyledTextString {
        return StyledTextString(styledTexts: styledTexts, renderMode: renderMode)
    }

    // MARK: Hashable

    public var hashValue: Int {
        guard let seed: Int = styledTexts.first?.hashValue else { return 0 }
        let count = styledTexts.count
        if count > 1 {
            return styledTexts[1...count].reduce(seed, { $0.combineHash(with: $1) })
        } else {
            return seed
        }
    }

    // MARK: Equatable

    public static func ==(lhs: StyledTextBuilder, rhs: StyledTextBuilder) -> Bool {
        if lhs === rhs { return true }
        return lhs.styledTexts == rhs.styledTexts
    }

}
