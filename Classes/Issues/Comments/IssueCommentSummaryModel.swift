//
//  IssueCommentSummaryModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentSummaryModel: IGListDiffable {

    let summary: String

    init(summary: String) {
        self.summary = summary
    }

    // MARK: IGListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return summary as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return true
    }

}
