//
//  PullRequest+IssueType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest: IssueType {

    var id: String {
        return fragments.nodeFields.id
    }

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

    func timelineViewModels(width: CGFloat) -> [ListDiffable] {
        var results = [ListDiffable]()

        for node in timeline.nodes ?? [] {
            guard let node = node else { continue }
            if let comment = node.asIssueComment {
                if let model = createCommentModel(
                    id: comment.fragments.nodeFields.id,
                    commentFields: comment.fragments.commentFields,
                    reactionFields: comment.fragments.reactionFields,
                    width: width
                    ) {
                    results.append(model)
                }
            } else if let unlabeled = node.asUnlabeledEvent,
                let date = GithubAPIDateFormatter().date(from: unlabeled.createdAt) {
                let model = IssueLabeledModel(
                    id: unlabeled.fragments.nodeFields.id,
                    actor: unlabeled.actor?.login ?? Strings.unknown,
                    title: unlabeled.label.name,
                    color: unlabeled.label.color,
                    date: date,
                    type: .removed
                )
                results.append(model)
            } else if let labeled = node.asLabeledEvent,
                let date = GithubAPIDateFormatter().date(from: labeled.createdAt) {
                let model = IssueLabeledModel(
                    id: labeled.fragments.nodeFields.id,
                    actor: labeled.actor?.login ?? Strings.unknown,
                    title: labeled.label.name,
                    color: labeled.label.color,
                    date: date,
                    type: .added
                )
                results.append(model)
            } else if let closed = node.asClosedEvent,
                let date = GithubAPIDateFormatter().date(from: closed.createdAt) {
                let model = IssueStatusEventModel(
                    id: closed.fragments.nodeFields.id,
                    actor: closed.actor?.login ?? Strings.unknown,
                    date: date,
                    status: .closed,
                    pullRequest: true
                )
                results.append(model)
            } else if let reopened = node.asReopenedEvent,
                let date = GithubAPIDateFormatter().date(from: reopened.createdAt) {
                let model = IssueStatusEventModel(
                    id: reopened.fragments.nodeFields.id,
                    actor: reopened.actor?.login ?? Strings.unknown,
                    date: date,
                    status: .open,
                    pullRequest: true
                )
                results.append(model)
            } else if let merged = node.asMergedEvent,
                let date = GithubAPIDateFormatter().date(from: merged.createdAt) {
                let model = IssueMergedModel(
                    date: date,
                    commitHash: merged.commit.oid,
                    actor: merged.actor?.login ?? Strings.unknown
                )
                results.append(model)
            }
        }

        return results
    }

}
