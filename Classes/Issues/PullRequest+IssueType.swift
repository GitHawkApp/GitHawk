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

    var assigneeFields: AssigneeFields {
        return fragments.assigneeFields
    }

    var milestoneFields: MilestoneFields? {
        return milestone?.fragments.milestoneFields
    }

    var reviewRequestModel: IssueAssigneesModel? {
        var models = [IssueAssigneeViewModel]()
        for node in reviewRequests?.nodes ?? [] {
            guard let node = node,
                let reviewer = node.requestedReviewer?.asUser,
                let url = URL(string: reviewer.avatarUrl)
                else { continue }
            models.append(IssueAssigneeViewModel(login: reviewer.login, avatarURL: url))
        }
        return IssueAssigneesModel(users: models, type: .reviewRequested)
    }

    var mergeModel: IssueMergeModel? {
        guard let commit = commits.nodes?.first??.commit
            else { return nil }

        var contexts = [IssueMergeContextModel]()
        for context in commit.status?.contexts ?? [] {
            guard let creator = context.creator,
                let avatarURL = URL(string: creator.avatarUrl)
                else { continue }
            contexts.append(IssueMergeContextModel(
                id: context.id,
                context: context.context,
                state: context.state,
                login: creator.login,
                avatarURL: avatarURL,
                description: context.description ?? ""
            ))
        }

        return IssueMergeModel(id: commit.id, state: mergeable, contexts: contexts)
    }

    var headPaging: HeadPaging {
        return timeline.pageInfo.fragments.headPaging
    }

    var fileChanges: FileChanges? {
        return FileChanges(additions: additions, deletions: deletions, changedFiles: changedFiles)
    }

    // FIXME: Super high cyclo complexity
    // swiftlint:disable cyclomatic_complexity
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
                let model = IssueStatusEventModel(
                    id: closed.fragments.nodeFields.id,
                    actor: closed.actor?.login ?? Constants.Strings.unknown,
                    commitHash: closed.closedCommit?.oid,
                    date: date,
                    status: .closed,
                    pullRequest: true
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
                    pullRequest: true
                )
                results.append(model)
            } else if let merged = node.asMergedEvent,
                let date = merged.createdAt.githubDate {
                let model = IssueStatusEventModel(
                    id: merged.fragments.nodeFields.id,
                    actor: merged.actor?.login ?? Constants.Strings.unknown,
                    commitHash: merged.mergedCommit?.oid ?? "",
                    date: date,
                    status: .merged,
                    pullRequest: true
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
            } else if let thread = node.asPullRequestReviewThread,
                let hunk = diffHunkModel(thread: thread) {
                // add the diff hunk FIRST then the threaded comments so that the section controllers end up stacked
                // on top of each other
                results.append(hunk)
                results += commentModels(
                    thread: thread,
                    contentSizeCategory: contentSizeCategory,
                    width: width,
                    owner: owner,
                    repo: repo
                )
            } else if let review = node.asPullRequestReview,
                let date = review.submittedAt?.githubDate {

                let details = IssueReviewDetailsModel(
                    actor: review.author?.login ?? Constants.Strings.unknown,
                    state: review.state,
                    date: date
                )

                let options = GitHubMarkdownOptions(
                    owner: owner,
                    repo: repo,
                    flavors: [.issueShorthand, .usernames],
                    width: width,
                    contentSizeCategory: contentSizeCategory
                )
                let bodies = CreateCommentModels(
                    markdown: review.fragments.commentFields.body,
                    options: options,
                    viewerCanUpdate: viewerCanUpdate
                )
                let model = IssueReviewModel(
                    id: review.fragments.nodeFields.id,
                    details: details,
                    bodyModels: bodies,
                    commentCount: review.comments.totalCount
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
                if let issueReference = referenced.subject.asIssue {
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
                } else if let prReference = referenced.subject.asPullRequest,
                    // do not ref the current PR
                    prReference.number != number {
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
            } else if let reviewRequested = node.asReviewRequestedEvent,
                let date = reviewRequested.createdAt.githubDate {
                let model = IssueRequestModel(
                    id: reviewRequested.fragments.nodeFields.id,
                    actor: reviewRequested.actor?.login ?? Constants.Strings.unknown,
                    user: reviewRequested.requestedReviewer?.asUser?.login ?? Constants.Strings.unknown,
                    date: date,
                    event: .reviewRequested,
                    contentSizeCategory: contentSizeCategory,
                    width: width
                )
                results.append(model)
            } else if let reviewRequestRemoved = node.asReviewRequestRemovedEvent,
                let date = reviewRequestRemoved.createdAt.githubDate {
                let model = IssueRequestModel(
                    id: reviewRequestRemoved.fragments.nodeFields.id,
                    actor: reviewRequestRemoved.actor?.login ?? Constants.Strings.unknown,
                    user: reviewRequestRemoved.requestedReviewer?.asUser?.login ?? Constants.Strings.unknown,
                    date: date,
                    event: .reviewRequestRemoved,
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
    // swiftlint:enable cyclomatic_complexity

    private func diffHunkModel(thread: Timeline.Node.AsPullRequestReviewThread) -> ListDiffable? {
        guard let node = thread.comments.nodes?.first, let firstComment = node else { return nil }
        let code = CreateDiffString(code: firstComment.diffHunk, limit: true)
        let text = NSAttributedStringSizing(containerWidth: 0, attributedText: code, inset: IssueDiffHunkPreviewCell.textViewInset)
        return IssueDiffHunkModel(path: firstComment.path, preview: text, offset: 0)
    }

    private func commentModels(
        thread: Timeline.Node.AsPullRequestReviewThread,
        contentSizeCategory: UIContentSizeCategory,
        width: CGFloat,
        owner: String,
        repo: String
        ) -> [ListDiffable] {
        var results = [ListDiffable]()

        let tailNodeId = thread.comments.nodes?.last??.fragments.nodeFields.id

        for node in thread.comments.nodes ?? [] {
            guard let fragments = node?.fragments else { continue }

            let id = fragments.nodeFields.id
            let isTail = id == tailNodeId

            if let model = createCommentModel(
                id: fragments.nodeFields.id,
                commentFields: fragments.commentFields,
                reactionFields: fragments.reactionFields,
                contentSizeCategory: contentSizeCategory,
                width: width,
                owner: owner,
                repo: repo,
                threadState: isTail ? .tail : .neck,
                viewerCanUpdate: false, // unsupported by github
                viewerCanDelete: false,
                isRoot: false
                ) {
                results.append(model)
            }
        }
        return results
    }

}
