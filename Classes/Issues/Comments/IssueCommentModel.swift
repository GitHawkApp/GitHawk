//
//  IssueCommentModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentModel: ListDiffable {


    let id: String
    let details: IssueCommentDetailsViewModel
    let bodyModels: [ListDiffable]
    let reactions: IssueCommentReactionViewModel
    let collapse: (model: AnyObject, height: CGFloat)?

    enum ThreadState {
        case none
        case head
        case neck
        case tail
    }
    let threadState: ThreadState

    init(
        id: String,
        details: IssueCommentDetailsViewModel,
        bodyModels: [ListDiffable],
        reactions: IssueCommentReactionViewModel,
        collapse: (AnyObject, CGFloat)?,
        threadState: ThreadState
        ) {
        self.id = id
        self.details = details
        self.bodyModels = bodyModels
        self.reactions = reactions
        self.collapse = collapse
        self.threadState = threadState
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }


}
