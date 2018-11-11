//
//  IssueCommentSummaryModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentSummaryModel: ListDiffable, ListSwiftDiffable {

    let summary: String

    init(summary: String) {
        self.summary = summary
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return summary as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return summary
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        return true
    }

}
