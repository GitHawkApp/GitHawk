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

    var locked: Bool {
        return fragments.lockableFields.locked
    }

    var viewerCanUpdate: Bool {
        return fragments.updatableFields.viewerCanUpdate
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

    var targetBranch: String? {
        return nil
    }

    var assigneeFields: AssigneeFields {
        return fragments.assigneeFields
    }

    var reviewRequestModel: IssueAssigneesModel? {
        return nil
    }

    var headPaging: HeadPaging {
        return timeline.pageInfo.fragments.headPaging
    }

    var milestoneFields: MilestoneFields? {
        return milestone?.fragments.milestoneFields
    }

    var fileChanges: FileChanges? {
        return nil
    }

    func mergeModel(availableTypes: [IssueMergeType]) -> IssueMergeModel? {
        return nil
    }

    func timelineViewModels(
        owner: String,
        repo: String,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat
        ) -> (models: [ListDiffable], mentionedUsers: [AutocompleteUser]) {
        guard let nodes = timeline.nodes else { return ([], []) }
        let cleanNodes = nodes.compactMap { $0 }

        var results = [ListDiffable]()
        var mentionedUsers = [AutocompleteUser]()

        for node in cleanNodes {
            if let comment = node.asIssueComment {
                if let model = createCommentModel(
                    id: comment.fragments.nodeFields.id,
                    commentFields: comment.fragments.commentFields,
                    reactionFields: comment.fragments.reactionFields,
                    contentSizeCategory: contentSizeCategory,
                    width: width,
                    owner: owner,
                    repo: repo,
                    threadState: .single,
                    viewerCanUpdate: comment.fragments.updatableFields.viewerCanUpdate,
                    viewerCanDelete: comment.fragments.deletableFields.viewerCanDelete,
                    isRoot: false
                    ) {
                    results.append(model)

                    mentionedUsers.append(AutocompleteUser(
                        avatarURL: model.details.avatarURL,
                        login: model.details.login
                    ))
                }
            } else if let unlabeled = node.asUnlabeledEvent,
                let date = unlabeled.createdAt.githubDate {
                let model = IssueLabeledModel(
                    id: unlabeled.fragments.nodeFields.id,
                    actor: unlabeled.actor?.login ?? Constants.Strings.unknown,
                    title: unlabeled.label.name,
                    color: unlabeled.label.color,
                    date: date,
                    type: .removed,
                    repoOwner: owner,
                    repoName: repo,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                results.append(model)
            } else if let labeled = node.asLabeledEvent,
                let date = labeled.createdAt.githubDate {
                let model = IssueLabeledModel(
                    id: labeled.fragments.nodeFields.id,
                    actor: labeled.actor?.login ?? Constants.Strings.unknown,
                    title: labeled.label.name,
                    color: labeled.label.color,
                    date: date,
                    type: .added,
                    repoOwner: owner,
                    repoName: repo,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                results.append(model)
            } else if let closed = node.asClosedEvent,
                let date = closed.createdAt.githubDate {
                let closer = closed.closer
                let model = IssueStatusEventModel(
                    id: closed.fragments.nodeFields.id,
                    actor: closed.actor?.login ?? Constants.Strings.unknown,
                    commitHash: closer?.asCommit?.oid ?? closer?.asPullRequest?.mergeCommit?.oid,
                    date: date,
                    status: .closed,
                    pullRequest: false
                )
                results.append(model)
            } else if let reopened = node.asReopenedEvent,
                let date = reopened.createdAt.githubDate {
                let model = IssueStatusEventModel(
                    id: reopened.fragments.nodeFields.id,
                    actor: reopened.actor?.login ?? Constants.Strings.unknown,
                    commitHash: nil,
                    date: date,
                    status: .reopened,
                    pullRequest: false
                )
                results.append(model)
            } else if let locked = node.asLockedEvent,
                let date = locked.createdAt.githubDate {
                    let model = IssueStatusEventModel(
                        id: locked.fragments.nodeFields.id,
                        actor: locked.actor?.login ?? Constants.Strings.unknown,
                        commitHash: nil,
                        date: date,
                        status: .locked,
                        pullRequest: false
                    )
                    results.append(model)
            } else if let unlocked = node.asUnlockedEvent,
                let date = unlocked.createdAt.githubDate {
                let model = IssueStatusEventModel(
                    id: unlocked.fragments.nodeFields.id,
                    actor: unlocked.actor?.login ?? Constants.Strings.unknown,
                    commitHash: nil,
                    date: date,
                    status: .unlocked,
                    pullRequest: false
                )
                results.append(model)
            } else if let referenced = node.asCrossReferencedEvent,
                let date = referenced.createdAt.githubDate {
                let id = referenced.fragments.nodeFields.id
                let actor = referenced.actor?.login ?? Constants.Strings.unknown
                if let issueReference = referenced.source.asIssue,
                    // do not ref the current issue
                    issueReference.number != number {
                    let model = IssueReferencedModel(
                        id: id,
                        owner: issueReference.repository.owner.login,
                        repo: issueReference.repository.name,
                        number: issueReference.number,
                        pullRequest: false,
                        state: issueReference.closed ? .closed : .open,
                        date: date,
                        title: issueReference.title,
                        actor: actor,
                        contentSizeCategory: contentSizeCategory,
                        width: width
                    )
                    results.append(model)
                } else if let prReference = referenced.source.asPullRequest {
                    let model = IssueReferencedModel(
                        id: id,
                        owner: prReference.repository.owner.login,
                        repo: prReference.repository.name,
                        number: prReference.number,
                        pullRequest: false,
                        state: prReference.merged ? .merged : prReference.closed ? .closed : .open,
                        date: date,
                        title: prReference.title,
                        actor: actor,
                        contentSizeCategory: contentSizeCategory,
                        width: width
                    )
                    results.append(model)
                }
            } else if let referenced = node.asReferencedEvent,
                let date = referenced.createdAt.githubDate {
                let repo = referenced.commitRepository.fragments.referencedRepositoryFields
                let id = referenced.fragments.nodeFields.id
                let actor = referenced.actor?.login ?? Constants.Strings.unknown
                if let commitRef = referenced.refCommit {
                    let model = IssueReferencedCommitModel(
                        id: id,
                        owner: repo.owner.login,
                        repo: repo.name,
                        hash: commitRef.oid,
                        actor: referenced.actor?.login ?? Constants.Strings.unknown,
                        date: date,
                        contentSizeCategory: contentSizeCategory,
                        width: width
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
                        title: issueReference.title,
                        actor: actor,
                        contentSizeCategory: contentSizeCategory,
                        width: width
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
                        title: prReference.title,
                        actor: actor,
                        contentSizeCategory: contentSizeCategory,
                        width: width
                    )
                    results.append(model)
                }
            } else if let rename = node.asRenamedTitleEvent,
                let date = rename.createdAt.githubDate {
                let text = IssueRenamedString(
                    previous: rename.previousTitle,
                    current: rename.currentTitle,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                let model = IssueRenamedModel(
                    id: rename.fragments.nodeFields.id,
                    actor: rename.actor?.login ?? Constants.Strings.unknown,
                    date: date,
                    titleChangeString: text
                )
                results.append(model)
            } else if let assigned = node.asAssignedEvent,
                let date = assigned.createdAt.githubDate {
                let model = IssueRequestModel(
                    id: assigned.fragments.nodeFields.id,
                    actor: assigned.actor?.login ?? Constants.Strings.unknown,
                    user: assigned.user?.login ?? Constants.Strings.unknown,
                    date: date,
                    event: .assigned,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                results.append(model)
            } else if let unassigned = node.asUnassignedEvent,
                let date = unassigned.createdAt.githubDate {
                let model = IssueRequestModel(
                    id: unassigned.fragments.nodeFields.id,
                    actor: unassigned.actor?.login ?? Constants.Strings.unknown,
                    user: unassigned.user?.login ?? Constants.Strings.unknown,
                    date: date,
                    event: .unassigned,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                results.append(model)
            } else if let milestone = node.asMilestonedEvent,
                let date = milestone.createdAt.githubDate {
                let model = IssueMilestoneEventModel(
                    id: milestone.fragments.nodeFields.id,
                    actor: milestone.actor?.login ?? Constants.Strings.unknown,
                    milestone: milestone.milestoneTitle,
                    date: date,
                    type: .milestoned,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                results.append(model)
            } else if let demilestone = node.asDemilestonedEvent,
                let date = demilestone.createdAt.githubDate {
                let model = IssueMilestoneEventModel(
                    id: demilestone.fragments.nodeFields.id,
                    actor: demilestone.actor?.login ?? Constants.Strings.unknown,
                    milestone: demilestone.milestoneTitle,
                    date: date,
                    type: .demilestoned,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                results.append(model)
            } else if let commit = node.asCommit,
                let urlString = commit.author?.user?.avatarUrl,
                let avatarURL = URL(string: urlString) {
                let model = IssueCommitModel(
                    id: commit.fragments.nodeFields.id,
                    login: commit.author?.user?.login ?? Constants.Strings.unknown,
                    avatarURL: avatarURL,
                    message: commit.messageHeadline,
                    hash: commit.oid
                )
                results.append(model)
            }
        }

        return (results, mentionedUsers)
    }

}
