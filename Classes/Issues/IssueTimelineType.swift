//
//  IssueTimelineType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import UIKit

struct IssueTimelineParams {
    let owner: String
    let repo: String
    let number: Int
    let viewerCanUpdate: Bool
    let width: CGFloat
}

protocol IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable?

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsCommit: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let urlString = author?.user?.avatarUrl,
            let avatarURL = URL(string: urlString) else { return nil }
        return IssueCommitModel(
            id: fragments.nodeFields.id,
            login: author?.user?.login ?? Constants.Strings.unknown,
            avatarURL: avatarURL,
            message: messageHeadline,
            hash: oid
        )
    }

}

protocol NodeFieldsType {
    var id: String { get }
}

protocol AsClosedEventType {
    var createdAt: String { get }
}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsIssue.Timeline.Node.AsClosedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueStatusEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            commitHash: closedCommit?.oid,
            date: date,
            status: .closed,
            pullRequest: true
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsClosedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueStatusEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            commitHash: closedCommit?.oid,
            date: date,
            status: .closed,
            pullRequest: true
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsLockedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueStatusEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            commitHash: nil,
            date: date,
            status: .locked,
            pullRequest: false
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsMergedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueStatusEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            commitHash: mergedCommit?.oid ?? "",
            date: date,
            status: .merged,
            pullRequest: true
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsIssueComment: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        return createCommentModel(
            id: fragments.nodeFields.id,
            commentFields: fragments.commentFields,
            reactionFields: fragments.reactionFields,
            width: params.width,
            owner: params.owner,
            repo: params.repo,
            threadState: .single,
            viewerCanUpdate: fragments.updatableFields.viewerCanUpdate,
            viewerCanDelete: fragments.deletableFields.viewerCanDelete,
            isRoot: false
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsLabeledEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueLabeledModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            title: label.name,
            color: label.color,
            date: date,
            type: .added,
            repoOwner: params.owner,
            repoName: params.repo,
            width: params.width
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsAssignedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueRequestModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            user: user?.login ?? Constants.Strings.unknown,
            date: date,
            event: .assigned,
            width: params.width
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsReopenedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueStatusEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            commitHash: nil,
            date: date,
            status: .reopened,
            pullRequest: true
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsUnlockedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueStatusEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            commitHash: nil,
            date: date,
            status: .unlocked,
            pullRequest: false
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsUnlabeledEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueLabeledModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            title: label.name,
            color: label.color,
            date: date,
            type: .removed,
            repoOwner: params.owner,
            repoName: params.repo,
            width: params.width
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsMilestonedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueMilestoneEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            milestone: milestoneTitle,
            date: date,
            type: .milestoned,
            width: params.width
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsReferencedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        let repo = commitRepository.fragments.referencedRepositoryFields
        let id = fragments.nodeFields.id
        let actor = self.actor?.login ?? Constants.Strings.unknown
        if let issueReference = subject.asIssue {
            return IssueReferencedModel(
                id: id,
                owner: repo.owner.login,
                repo: repo.name,
                number: issueReference.number,
                pullRequest: false,
                state: issueReference.closed ? .closed : .open,
                date: date,
                title: issueReference.title,
                actor: actor,
                width: params.width
            )
        } else if let prReference = subject.asPullRequest,
            // do not ref the current PR
            prReference.number != params.number {
            return IssueReferencedModel(
                id: id,
                owner: repo.owner.login,
                repo: repo.name,
                number: prReference.number,
                pullRequest: false,
                state: prReference.merged ? .merged : prReference.closed ? .closed : .open,
                date: date,
                title: prReference.title,
                actor: actor,
                width: params.width
            )
        }
        return nil
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsUnassignedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueRequestModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            user: user?.login ?? Constants.Strings.unknown,
            date: date,
            event: .unassigned,
            width: params.width
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsDemilestonedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueMilestoneEventModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            milestone: milestoneTitle,
            date: date,
            type: .demilestoned,
            width: params.width
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsPullRequestReview: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = submittedAt?.githubDate else { return nil }

        let details = IssueReviewDetailsModel(
            actor: author?.login ?? Constants.Strings.unknown,
            state: state,
            date: date
        )

        let options = GitHubMarkdownOptions(
            owner: params.owner,
            repo: params.repo,
            flavors: [.issueShorthand, .usernames]
        )
        let bodies = CreateCommentModels(
            markdown: fragments.commentFields.body,
            width: params.width,
            options: options,
            viewerCanUpdate: params.viewerCanUpdate
        )
        return IssueReviewModel(
            id: fragments.nodeFields.id,
            details: details,
            bodyModels: bodies,
            commentCount: comments.totalCount
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsRenamedTitleEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        let text = IssueRenamedString(
            previous: previousTitle,
            current: currentTitle,
            width: params.width
        )
        return IssueRenamedModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            date: date,
            titleChangeString: text
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsCrossReferencedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        let id = fragments.nodeFields.id
        let actor = self.actor?.login ?? Constants.Strings.unknown
        if let issueReference = source.asIssue,
            // do not ref the current issue
            issueReference.number != params.number {
            return IssueReferencedModel(
                id: id,
                owner: issueReference.repository.owner.login,
                repo: issueReference.repository.name,
                number: issueReference.number,
                pullRequest: false,
                state: issueReference.closed ? .closed : .open,
                date: date,
                title: issueReference.title,
                actor: actor,
                width: params.width
            )
        } else if let prReference = source.asPullRequest {
            return IssueReferencedModel(
                id: id,
                owner: prReference.repository.owner.login,
                repo: prReference.repository.name,
                number: prReference.number,
                pullRequest: false,
                state: prReference.merged ? .merged : prReference.closed ? .closed : .open,
                date: date,
                title: prReference.title,
                actor: actor,
                width: params.width
            )
        }
        return nil
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsReviewRequestedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueRequestModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            user: requestedReviewer?.asUser?.login ?? Constants.Strings.unknown,
            date: date,
            event: .reviewRequested,
            width: params.width
        )
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsPullRequestReviewThread: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        return nil
    }

}

extension IssueOrPullRequestQuery.Data.Repository.IssueOrPullRequest.AsPullRequest.Timeline.Node.AsReviewRequestRemovedEvent: IssueTimelineType {

    func render(params: IssueTimelineParams) -> ListDiffable? {
        guard let date = createdAt.githubDate else { return nil }
        return IssueRequestModel(
            id: fragments.nodeFields.id,
            actor: actor?.login ?? Constants.Strings.unknown,
            user: requestedReviewer?.asUser?.login ?? Constants.Strings.unknown,
            date: date,
            event: .reviewRequestRemoved,
            width: params.width
        )
    }

}

