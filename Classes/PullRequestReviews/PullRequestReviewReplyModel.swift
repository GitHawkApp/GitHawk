//
//  PullRequestReviewReplyModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 1/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class PullRequestReviewReplyModel: ListDiffable {

    let replyID: Int

    init(replyID: Int) {
        self.replyID = replyID
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return "reply-\(replyID)" as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? PullRequestReviewReplyModel else { return false }
        return replyID == object.replyID
    }

}
