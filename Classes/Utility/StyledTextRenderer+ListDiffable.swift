//
//  StyledTextRenderer+ListDiffable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import StyledText
import IGListKit

extension StyledTextRenderer: ListDiffable {

    public func diffIdentifier() -> NSObjectProtocol {
        return builder.hashValue
    }

    public func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? StyledTextRenderer else { return false }
        return builder == object.builder
    }

}
