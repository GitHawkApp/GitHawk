//
//  IssueTitleModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledTextKit

final class IssueTitleModel: ListDiffable {

    let string: StyledTextRenderer
    let trailingMetadata: Bool

    init(string: StyledTextRenderer, trailingMetadata: Bool) {
        self.string = string
        self.trailingMetadata = trailingMetadata
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return string.string.hashValue as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueTitleModel else { return false }
        return trailingMetadata == object.trailingMetadata
    }

}
