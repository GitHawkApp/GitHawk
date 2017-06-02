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
    let collapse: (model: AnyObject, height: CGFloat)?

    init(
        id: Int,
        details: IssueCommentDetailsViewModel,
        bodyModels: [IGListDiffable],
        collapse: (AnyObject, CGFloat)?
        ) {
        self.number = id
        self.details = details
        self.bodyModels = bodyModels
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
