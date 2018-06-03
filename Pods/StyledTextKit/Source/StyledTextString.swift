//
//  StyledTextKitResult.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 3/17/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import UIKit

public final class StyledTextString: Hashable, Equatable {

    public enum RenderMode {
        case trimWhitespaceAndNewlines
        case trimWhitespace
        case preserve
    }

    public let styledTexts: [StyledText]
    public let renderMode: RenderMode

    public init(styledTexts: [StyledText], renderMode: RenderMode = .trimWhitespaceAndNewlines) {
        self.styledTexts = styledTexts
        self.renderMode = renderMode
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
        switch renderMode {
        case .trimWhitespaceAndNewlines: return result.trimCharactersInSet(charSet: CharacterSet.whitespacesAndNewlines)
        case .trimWhitespace: return result.trimCharactersInSet(charSet: CharacterSet.whitespaces)
        case .preserve: return result
        }
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
