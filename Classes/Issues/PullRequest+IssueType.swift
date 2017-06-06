//
//  PullRequest+IssueType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension PullRequestQuery.Data.Repository.PullRequest: IssueType {

    var pullRequest: Bool {
        return true
    }

    var labelableFields: LabelableFields {
        return fragments.labelableFields
    }

    var commentFields: CommentFields {
        return fragments.commentFields
    }

    var reactionFields: ReactionFields {
        return fragments.reactionFields
    }

    var closableFields: ClosableFields {
        return fragments.closableFields
    }

    func timelineViewModels(width: CGFloat) -> [IGListDiffable] {
        var results = [IGListDiffable]()

        for node in timeline.nodes ?? [] {
            guard let node = node else { continue }
            if let comment = node.asIssueComment {
                if let model = createCommentModel(
                    id: comment.id,
                    commentFields: comment.fragments.commentFields,
                    reactionFields: comment.fragments.reactionFields,
                    width: width
                    ) {
                    results.append(model)
                }
            }
        }

        return results
    }

}
