//
//  Issue+IssueType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsIssue: IssueType {

    var id: String {
        return fragments.nodeFields.id
    }

    var pullRequest: Bool {
        return false
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

    var merged: Bool {
        return false
    }

    var locked: Bool {
        return fragments.lockableFields.locked
    }

    var assigneeFields: AssigneeFields {
        return fragments.assigneeFields
    }

    var reviewRequestModel: IssueAssigneesModel? {
        return nil
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
                    width: width,
                    threadState: .single
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
                    commitHash: closed.closedCommit?.oid,
                    date: date,
                    status: .closed,
                    pullRequest: false
                )
                results.append(model)
            } else if let reopened = node.asReopenedEvent,
                let date = GithubAPIDateFormatter().date(from: reopened.createdAt) {
                let model = IssueStatusEventModel(
                    id: reopened.fragments.nodeFields.id,
                    actor: reopened.actor?.login ?? Strings.unknown,
                    commitHash: nil,
                    date: date,
                    status: .reopened,
                    pullRequest: false
                )
                results.append(model)
            } else if let locked = node.asLockedEvent,
                let date = GithubAPIDateFormatter().date(from: locked.createdAt) {
                    let model = IssueStatusEventModel(
                        id: locked.fragments.nodeFields.id,
                        actor: locked.actor?.login ?? Strings.unknown,
                        commitHash: nil,
                        date: date,
                        status: .locked,
                        pullRequest: false
                    )
                    results.append(model)
            } else if let unlocked = node.asUnlockedEvent,
                let date = GithubAPIDateFormatter().date(from: unlocked.createdAt) {
                let model = IssueStatusEventModel(
                    id: unlocked.fragments.nodeFields.id,
                    actor: unlocked.actor?.login ?? Strings.unknown,
                    commitHash: nil,
                    date: date,
                    status: .unlocked,
                    pullRequest: false
                )
                results.append(model)
            } else if let referenced = node.asReferencedEvent,
                let date = GithubAPIDateFormatter().date(from: referenced.createdAt) {
                let repo = referenced.commitRepository.fragments.referencedRepositoryFields
                let id = referenced.fragments.nodeFields.id
                if let commitRef = referenced.refCommit {
                    let model = IssueReferencedCommitModel(
                        id: id,
                        owner: repo.owner.login,
                        repo: repo.name,
                        hash: commitRef.oid,
                        actor: referenced.actor?.login ?? Strings.unknown,
                        date: date
                    )
                    results.append(model)
                } else if let issueReference = referenced.subject.asIssue,
                    // do not ref the current issue
                    issueReference.number != number {
                    let model = IssueReferencedModel(
                        id: id,
                        owner: repo.owner.login,
                        repo: repo.name,
                        number: issueReference.number,
                        pullRequest: false,
                        state: issueReference.closed ? .closed : .open,
                        date: date,
                        title: issueReference.title
                    )
                    results.append(model)
                } else if let prReference = referenced.subject.asPullRequest {
                    let model = IssueReferencedModel(
                        id: id,
                        owner: repo.owner.login,
                        repo: repo.name,
                        number: prReference.number,
                        pullRequest: false,
                        state: prReference.merged ? .merged : prReference.closed ? .closed : .open,
                        date: date,
                        title: prReference.title
                    )
                    results.append(model)
                }
            } else if let rename = node.asRenamedTitleEvent,
                let date = GithubAPIDateFormatter().date(from: rename.createdAt) {
                let text = IssueRenamedString(
                    previous: rename.previousTitle,
                    current: rename.currentTitle,
                    width: width
                )
                let model = IssueRenamedModel(
                    id: rename.fragments.nodeFields.id,
                    actor: rename.actor?.login ?? Strings.unknown,
                    date: date,
                    titleChangeString: text
                )
                results.append(model)
            } else if let assigned = node.asAssignedEvent,
                let date = GithubAPIDateFormatter().date(from: assigned.createdAt) {
                let model = IssueRequestModel(
                    id: assigned.fragments.nodeFields.id,
                    actor: assigned.actor?.login ?? Strings.unknown,
                    user: assigned.user?.login ?? Strings.unknown,
                    date: date,
                    event: .assigned
                )
                results.append(model)
            } else if let unassigned = node.asUnassignedEvent,
                let date = GithubAPIDateFormatter().date(from: unassigned.createdAt) {
                let model = IssueRequestModel(
                    id: unassigned.fragments.nodeFields.id,
                    actor: unassigned.actor?.login ?? Strings.unknown,
                    user: unassigned.user?.login ?? Strings.unknown,
                    date: date,
                    event: .unassigned
                )
                results.append(model)
            }
        }

        return results
    }

}
