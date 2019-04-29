//
//  IssueCommentHrModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentHrModel: NSObject, ListDiffable, ListSwiftDiffable {

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return self
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return description
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
