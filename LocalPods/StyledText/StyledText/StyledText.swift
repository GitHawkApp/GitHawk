//
//  StyledText.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public struct StyledText: Hashable, Equatable {

    let text: String
    let style: TextStyle

    public init(
        text: String = "",
        style: TextStyle = TextStyle()
        ) {
        self.text = text
        self.style = style
    }

    internal func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        var attributes = style.attributes
        attributes[.font] = style.font(contentSizeCategory: contentSizeCategory)
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
