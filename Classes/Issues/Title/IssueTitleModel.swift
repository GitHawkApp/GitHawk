//
//  IssueTitleModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/13/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueTitleModel: ListDiffable {

    let attributedString: NSAttributedStringSizing
    let trailingMetadata: Bool

    init(attributedString: NSAttributedStringSizing, trailingMetadata: Bool) {
        self.attributedString = attributedString
        self.trailingMetadata = trailingMetadata
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return attributedString.diffIdentifier()
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueTitleModel else { return false }
        return trailingMetadata == object.trailingMetadata
            && attributedString.isEqual(toDiffableObject: object)
    }

}
