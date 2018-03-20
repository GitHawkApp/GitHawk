//
//  StyledTextResult.swift
//  StyledText
//
//  Created by Ryan Nystrom on 3/17/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

public final class StyledTextString: Hashable, Equatable {

    public let styledTexts: [StyledText]

    init(styledTexts: [StyledText]) {
        self.styledTexts = styledTexts
        _hashValue = styledTexts.reduce(0) {
            $0 == 0 ? $1.hashValue : $0 ^ $1.hashValue
        }
    }

    public var allText: String {
        return styledTexts.reduce("", { $0 + $1.text })
    }

    public func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        let result = NSMutableAttributedString()
        styledTexts.forEach { result.append($0.render(contentSizeCategory: contentSizeCategory)) }
        return result
    }

    // MARK: Hashable

    private let _hashValue: Int
    public var hashValue: Int {
        return _hashValue
    }

    // MARK: Equatable

    public static func ==(lhs: StyledTextString, rhs: StyledTextString) -> Bool {
        if lhs === rhs { return true }
        return lhs.styledTexts == rhs.styledTexts
    }

}
