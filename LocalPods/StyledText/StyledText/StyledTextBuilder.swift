//
//  StyledTextBuilder.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct StyledTextBuilder: Hashable, Equatable {

    internal let styledTexts: [StyledText]
    internal var savedStyle: TextStyle? = nil

    init(styledText: StyledText) {
        self.init(styledTexts: [styledText])
    }

    init(styledTexts: [StyledText]) {
        self.styledTexts = styledTexts
        self.savedStyle = nil
    }

    public func add(styledTexts: [StyledText]) -> StyledTextBuilder {
        var builder = StyledTextBuilder(styledTexts: self.styledTexts + styledTexts)
        builder.savedStyle = savedStyle
        return builder
    }

    public func add(styledText: StyledText) -> StyledTextBuilder {
        return add(styledTexts: [styledText])
    }

    public func save() -> StyledTextBuilder {
        var builder = self
        builder.savedStyle = styledTexts.last?.style
        return builder
    }

    public func restore() -> StyledTextBuilder {
        guard let savedStyle = self.savedStyle else { return self }
        var builder = add(styledText: StyledText(style: savedStyle))
        builder.savedStyle = nil
        return builder
    }

    public func add(
        text: String,
        traits: UIFontDescriptorSymbolicTraits? = nil,
        attributes: [NSAttributedStringKey: AnyObject]? = nil
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
            nextStyle = TextStyle(
                name: tip.style.name,
                size: tip.style.size,
                attributes: nextAttributes,
                traits: tip.style.traits.union(traits),
                minSize: tip.style.minSize,
                maxSize: tip.style.maxSize
            )
        } else {
            nextStyle = tip.style
        }

        return add(
            styledText: StyledText(
                text: text,
                style: nextStyle
            )
        )
    }

    public func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        let result = NSMutableAttributedString()
        styledTexts.forEach { result.append($0.render(contentSizeCategory: contentSizeCategory)) }
        return result
    }

    public var hashValue: Int {
        guard let seed: Int = styledTexts.first?.hashValue else { return 0 }
        let count = styledTexts.count
        if count > 1 {
            return styledTexts[1...count].reduce(seed, { $0.combineHash(with: $1) })
        } else {
            return seed
        }
    }

    public static func == (lhs: StyledTextBuilder, rhs: StyledTextBuilder) -> Bool {
        return lhs.styledTexts == rhs.styledTexts
    }

}

