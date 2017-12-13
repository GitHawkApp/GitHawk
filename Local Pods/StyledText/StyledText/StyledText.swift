//
//  StyledText.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct StyledText {

    let text: String
    let style: TextStyle

    init(
        text: String = "",
        style: TextStyle = TextStyle()
        ) {
        self.text = text
        self.style = style
    }

    internal func font(size: CGFloat) -> UIFont {
        let font = UIFont(name: style.name, size: size) ?? UIFont.systemFont(ofSize: size)
        return font.addingTraits(traits: style.traits)
    }

    internal func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        var attributes = style.attributes
        attributes[.font] = font(size: contentSizeCategory.preferredContentSize(style.size))
        return NSAttributedString(string: text, attributes: attributes)
    }

    public var hashValue: Int {
        return text
            .combineHash(with: style)
    }

    public static func == (lhs: StyledText, rhs: StyledText) -> Bool {
        return lhs.text == rhs.text
            && lhs.style == rhs.style
    }

}
