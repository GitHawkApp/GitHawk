//
//  IssueCommentModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentModel {

    let id: Int
    let details: IssueCommentDetailsViewModel
    let bodyModels: [IGListDiffable]

    init(
        id: Int,
        details: IssueCommentDetailsViewModel,
        bodyModels: [IGListDiffable]
        ) {
        self.id = id
        self.details = details
        self.bodyModels = bodyModels
    }

}

extension IssueCommentModel: IGListDiffable {

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }

}
