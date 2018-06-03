//
//  Font.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 2/19/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit

public enum Font: Hashable, Equatable {

    public enum SystemFont: Hashable, Equatable {
        case `default`
        case bold
        case italic
        case weighted(UIFont.Weight)
        case monospaced(UIFont.Weight)

        // MARK: Hashable

        public var hashValue: Int {
            switch self {
            case .default: return 0
            case .bold: return 1
            case .italic: return 2
            case .weighted(let weight): return weight.hashValue
            case .monospaced(let weight): return weight.hashValue
            }
        }

        // MARK: Equatable

        public static func ==(lhs: SystemFont, rhs: SystemFont) -> Bool {
            return lhs.hashValue == rhs.hashValue
        }

    }

    case name(String)
    case descriptor(UIFontDescriptor)
    case system(SystemFont)

    // MARK: Hashable

    public var hashValue: Int {
        switch self {
        case .name(let name): return name.hashValue
        case .descriptor(let descriptor): return descriptor.hashValue
        case .system(let system): return system.hashValue
        }
    }

    // MARK: Equatable

    public static func ==(lhs: Font, rhs: Font) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

}
