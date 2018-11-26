//
//  StyledTextRenderer+ListDiffable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/18/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

extension StyledTextRenderer: ListDiffable, ListSwiftDiffable {

    public func diffIdentifier() -> NSObjectProtocol {
        return string.hashValue as NSObjectProtocol
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? StyledTextRenderer else { return false }
        return string == object.string
    }

    // MARK: ListSwiftDiffable

    public var identifier: String {
        return "\(string.hashValue)"
    }

    public func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? StyledTextRenderer else { return false }
        return string == value.string
    }

}
