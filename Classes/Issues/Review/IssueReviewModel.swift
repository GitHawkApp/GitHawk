//
//  IssueReviewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueReviewModel: ListDiffable {

    let id: String
    let details: IssueReviewDetailsModel
    let bodyModels: [ListDiffable]
    let commentCount: Int

    init(id: String, details: IssueReviewDetailsModel, bodyModels: [ListDiffable], commentCount: Int) {
        self.id = id
        self.details = details
        self.bodyModels = bodyModels
        self.commentCount = commentCount
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        // uses binding SC, so must be true if the identifiers match
        return true
    }

}
