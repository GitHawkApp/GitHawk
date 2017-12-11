//
//  StyledText.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension UIContentSizeCategory {

    var multiplier: CGFloat {
        switch self {
        case .accessibilityExtraExtraExtraLarge: return 23 / 16
        case .accessibilityExtraExtraLarge: return 22 / 16
        case .accessibilityExtraLarge: return 21 / 16
        case .accessibilityLarge: return 20 / 16
        case .accessibilityMedium: return 19 / 16
        case .extraExtraExtraLarge: return 19 / 16
        case .extraExtraLarge: return 18 / 16
        case .extraLarge: return 17 / 16
        case .large: return 1
        case .medium: return 15 / 16
        case .small: return 14 / 16
        case .extraSmall: return 13 / 16
        default: return 1
        }
    }

    func preferredContentSize(
        _ base: CGFloat,
        minSize: CGFloat = 0,
        maxSize: CGFloat = CGFloat.greatestFiniteMagnitude
        ) -> CGFloat {
        let result = base * multiplier
        return min(max(result, minSize), maxSize)
    }

}

extension Hashable {
    func combineHash<T: Hashable>(with hashableOther: T) -> Int {
        let ownHash = self.hashValue
        let otherHash = hashableOther.hashValue
        return (ownHash << 5) &+ ownHash &+ otherHash
    }
}

struct TextStyle: Hashable, Equatable {

    enum FontOption: Hashable, Equatable {
        case bold
        case italic
        case normal
        case custom(String)

        var hashValue: Int {
            switch self {
            case .bold: return 1
            case .italic: return 2
            case .normal: return 3
            case .custom(let name): return name.hashValue
            }
        }

        static func == (lhs: FontOption, rhs: FontOption) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }
    }

    let size: CGFloat
    let fontOption: FontOption
    let minSize: CGFloat
    let maxSize: CGFloat

    init(size: CGFloat, fontOption: FontOption, minSize: CGFloat = 0, maxSize: CGFloat = .greatestFiniteMagnitude) {
        self.size = size
        self.fontOption = fontOption
        self.minSize = minSize
        self.maxSize = maxSize

        self._hashValue = size
            .combineHash(with: fontOption)
            .combineHash(with: minSize)
            .combineHash(with: maxSize)
    }

    private let _hashValue: Int
    var hashValue: Int {
        return _hashValue
    }

    static func == (lhs: TextStyle, rhs: TextStyle) -> Bool {
        return lhs.size == rhs.size
        && lhs.fontOption == rhs.fontOption
        && lhs.minSize == rhs.minSize
        && rhs.maxSize == rhs.maxSize
    }

}

struct StyledText: Hashable, Equatable {

    let text: String
    let style: TextStyle
    let attributes: [NSAttributedStringKey: Any]

    func font(size: CGFloat) -> UIFont {
        switch style.fontOption {
        case .normal: return UIFont.systemFont(ofSize: size)
        case .bold: return UIFont.boldSystemFont(ofSize: size)
        case .italic: return UIFont.italicSystemFont(ofSize: size)
        case .custom(let name): return UIFont(name: name, size: size)!
        }
    }

    func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        var attributes = self.attributes
        attributes[.font] = font(size: contentSizeCategory.preferredContentSize(style.size))
        return NSAttributedString(string: text, attributes: attributes)
    }

    var hashValue: Int {
        return text
            .combineHash(with: style)
    }

    static func == (lhs: StyledText, rhs: StyledText) -> Bool {
        return lhs.text == rhs.text
        && lhs.style == rhs.style
    }

}

struct StyledTextBuilder {

    let styledTexts: [StyledText]

    func adding(_ styledText: StyledText) -> StyledTextBuilder {
        return adding([styledText])
    }

    func adding(_ styledTexts: [StyledText]) -> StyledTextBuilder {
        return StyledTextBuilder(styledTexts: self.styledTexts + styledTexts)
    }

    func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        let result = NSMutableAttributedString()
        styledTexts.forEach { result.append($0.render(contentSizeCategory: contentSizeCategory)) }
        return result
    }

}
