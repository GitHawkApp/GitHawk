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
                let reviewer = node.reviewer,
                let url = URL(string: reviewer.avatarUrl)
                else { continue }
            models.append(IssueAssigneeViewModel(login: reviewer.login, avatarURL: url))
        }
        return IssueAssigneesModel(users: models, type: .reviewRequested)
    }

    var headPaging: HeadPaging {
        return timeline.pageInfo.fragments.headPaging
    }

    // FIXME: Super high cyclo complexity
    // swiftlint:disable cyclomatic_complexity
    func timelineViewModels(
        owner: String,
        repo: String,
        width: CGFloat
        ) -> (models: [ListDiffable], mentionedUsers: [AutocompleteUser]) {
        guard let nodes = timeline.nodes else { return ([], []) }
        let cleanNodes = nodes.flatMap { $0 }

        var results = [ListDiffable]()
        var mentionedUsers = [AutocompleteUser]()

        for node in cleanNodes {
            if let comment = node.asIssueComment {
                if let model = createCommentModel(
                    id: comment.fragments.nodeFields.id,
                    commentFields: comment.fragments.commentFields,
                    reactionFields: comment.fragments.reactionFields,
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
                let date = GithubAPIDateFormatter().date(from: unlabeled.createdAt) {
                let model = IssueLabeledModel(
                    id: unlabeled.fragments.nodeFields.id,
                    actor: unlabeled.actor?.login ?? Constants.Strings.unknown,
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
                    actor: labeled.actor?.login ?? Constants.Strings.unknown,
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
                    actor: closed.actor?.login ?? Constants.Strings.unknown,
                    commitHash: closed.closedCommit?.oid,
                    date: date,
                    status: .closed,
                    pullRequest: true
                )
                results.append(model)
            } else if let reopened = node.asReopenedEvent,
                let date = GithubAPIDateFormatter().date(from: reopened.createdAt) {
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
                let date = GithubAPIDateFormatter().date(from: merged.createdAt) {
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
                let date = GithubAPIDateFormatter().date(from: locked.createdAt) {
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
                let date = GithubAPIDateFormatter().date(from: unlocked.createdAt) {
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
                    width: width,
                    owner: owner,
                    repo: repo
                )
            } else if let review = node.asPullRequestReview,
                let dateString = review.submittedAt,
                let date = GithubAPIDateFormatter().date(from: dateString) {

                // avoid displaying reviews that are empty comments (e.g. no actual content)
                // the real content for these is likely a PR review thread comment instead
                let markdown = review.fragments.commentFields.body.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                guard !markdown.isEmpty || review.state != .commented else { continue }

                let details = IssueReviewDetailsModel(
                    actor: review.author?.login ?? Constants.Strings.unknown,
                    state: review.state,
                    date: date
                )

                let options = GitHubMarkdownOptions(owner: owner, repo: repo, flavors: [.issueShorthand, .usernames])
                let bodies = CreateCommentModels(
                    markdown: review.fragments.commentFields.body,
                    width: width,
                    options: options
                )
                let model = IssueReviewModel(
                    id: review.fragments.nodeFields.id,
                    details: details,
                    bodyModels: bodies
                )
                results.append(model)
            } else if let referenced = node.asReferencedEvent,
                let date = GithubAPIDateFormatter().date(from: referenced.createdAt) {
                let repo = referenced.commitRepository.fragments.referencedRepositoryFields
                let id = referenced.fragments.nodeFields.id
                if let issueReference = referenced.subject.asIssue {
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
                    actor: rename.actor?.login ?? Constants.Strings.unknown,
                    date: date,
                    titleChangeString: text
                )
                results.append(model)
            } else if let assigned = node.asAssignedEvent,
                let date = GithubAPIDateFormatter().date(from: assigned.createdAt) {
                let model = IssueRequestModel(
                    id: assigned.fragments.nodeFields.id,
                    actor: assigned.actor?.login ?? Constants.Strings.unknown,
                    user: assigned.user?.login ?? Constants.Strings.unknown,
                    date: date,
                    event: .assigned
                )
                results.append(model)
            } else if let unassigned = node.asUnassignedEvent,
                let date = GithubAPIDateFormatter().date(from: unassigned.createdAt) {
                let model = IssueRequestModel(
                    id: unassigned.fragments.nodeFields.id,
                    actor: unassigned.actor?.login ?? Constants.Strings.unknown,
                    user: unassigned.user?.login ?? Constants.Strings.unknown,
                    date: date,
                    event: .unassigned
                )
                results.append(model)
            } else if let reviewRequested = node.asReviewRequestedEvent,
                let date = GithubAPIDateFormatter().date(from: reviewRequested.createdAt) {
                let model = IssueRequestModel(
                    id: reviewRequested.fragments.nodeFields.id,
                    actor: reviewRequested.actor?.login ?? Constants.Strings.unknown,
                    user: reviewRequested.subject.login,
                    date: date,
                    event: .reviewRequested
                )
                results.append(model)
            } else if let reviewRequestRemoved = node.asReviewRequestRemovedEvent,
                let date = GithubAPIDateFormatter().date(from: reviewRequestRemoved.createdAt) {
                let model = IssueRequestModel(
                    id: reviewRequestRemoved.fragments.nodeFields.id,
                    actor: reviewRequestRemoved.actor?.login ?? Constants.Strings.unknown,
                    user: reviewRequestRemoved.subject.login,
                    date: date,
                    event: .reviewRequestRemoved
                )
                results.append(model)
            } else if let milestone = node.asMilestonedEvent,
                let date = GithubAPIDateFormatter().date(from: milestone.createdAt) {
                let model = IssueMilestoneEventModel(
                    id: milestone.fragments.nodeFields.id,
                    actor: milestone.actor?.login ?? Constants.Strings.unknown,
                    milestone: milestone.milestoneTitle,
                    date: date,
                    type: .milestoned
                )
                results.append(model)
            } else if let demilestone = node.asDemilestonedEvent,
                let date = GithubAPIDateFormatter().date(from: demilestone.createdAt) {
                let model = IssueMilestoneEventModel(
                    id: demilestone.fragments.nodeFields.id,
                    actor: demilestone.actor?.login ?? Constants.Strings.unknown,
                    milestone: demilestone.milestoneTitle,
                    date: date,
                    type: .demilestoned
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
        return IssueDiffHunkModel(path: firstComment.path, preview: text)
    }

    private func commentModels(
        thread: Timeline.Node.AsPullRequestReviewThread,
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
