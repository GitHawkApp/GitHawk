//
//  IssueCommentModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentModel: IGListDiffable {

    let number: Int
    let details: IssueCommentDetailsViewModel
    let bodyModels: [IGListDiffable]
    let reactions: IssueCommentReactionViewModel
    let collapse: (model: AnyObject, height: CGFloat)?

    init(
        number: Int,
        details: IssueCommentDetailsViewModel,
        bodyModels: [IGListDiffable],
        reactions: IssueCommentReactionViewModel,
        collapse: (AnyObject, CGFloat)?
        ) {
        self.number = number
        self.details = details
        self.bodyModels = bodyModels
        self.reactions = reactions
        self.collapse = collapse
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return number as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }


}
