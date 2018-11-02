//
//  StyledTextKit.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import UIKit

public class StyledText: Hashable, Equatable {

    public enum Storage: Hashable, Equatable {
        case text(String)
        case attributedText(NSAttributedString)

        // MARK: Hashable

        public var hashValue: Int {
            switch self {
            case .text(let text): return text.hashValue
            case .attributedText(let text): return text.hashValue
            }
        }

        // MARK: Equatable

        public static func ==(lhs: Storage, rhs: Storage) -> Bool {
            switch lhs {
            case .text(let lhsText):
                switch rhs {
                case .text(let rhsText): return lhsText == rhsText
                case .attributedText: return false
                }
            case .attributedText(let lhsText):
                switch rhs {
                case .text: return false
                case .attributedText(let rhsText): return lhsText == rhsText
                }
            }
        }

    }

    public let storage: Storage
    public let style: TextStyle

    public init(storage: Storage = .text(""), style: TextStyle = TextStyle()) {
        self.storage = storage
        self.style = style
    }

    public convenience init(text: String, style: TextStyle = TextStyle()) {
        self.init(storage: .text(text), style: style)
    }

    internal var text: String {
        switch storage {
        case .text(let text): return text
        case .attributedText(let text): return text.string
        }
    }

    internal func render(contentSizeCategory: UIContentSizeCategory) -> NSAttributedString {
        var attributes = style.attributes
        attributes[.font] = style.font(contentSizeCategory: contentSizeCategory)
        switch storage {
        case .text(let text): return NSAttributedString(string: text, attributes: attributes)
        case .attributedText(let text):
            guard text.length > 0 else { return text }
            let mutable = text.mutableCopy() as? NSMutableAttributedString ?? NSMutableAttributedString()
            let range = NSRange(location: 0, length: mutable.length)
            for (k, v) in attributes {
                // avoid overwriting attributes set by the stored string
                if mutable.attribute(k, at: 0, effectiveRange: nil) == nil {
                    mutable.addAttribute(k, value: v, range: range)
                }
            }
            return mutable
        }
    }

    // MARK: Hashable

    public var hashValue: Int {
        return storage
            .combineHash(with: style)
    }

    // MARK: Equatable

    public static func ==(lhs: StyledText, rhs: StyledText) -> Bool {
        return lhs.storage == rhs.storage
            && lhs.style == rhs.style
    }

}
