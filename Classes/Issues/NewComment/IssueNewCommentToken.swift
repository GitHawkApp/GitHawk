//
//  IssueNewCommentToken.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueNewCommentToken: ListDiffable {

    let subjectId: String

    init(_ subjectId: String) {
        self.subjectId = subjectId
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "IssueNewCommentToken" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
