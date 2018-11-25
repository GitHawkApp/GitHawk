//
//  IssueResult.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import FlatCache
import StyledTextKit

struct IssueResult: Cachable {

    let id: String
    let pullRequest: Bool
    let title: StyledTextRenderer
    let labels: IssueLabelsModel
    let assignee: IssueAssigneesModel
    // optional models
    let rootComment: IssueCommentModel?
    let reviewers: IssueAssigneesModel?
    let milestone: Milestone?
    let targetBranch: IssueTargetBranchModel?
    // end optionals
    let timelinePages: [IssueTimelinePage]
    let viewerIsSubscribed: Bool
    let viewerCanUpdate: Bool
    let hasIssuesEnabled: Bool
    let viewerCanAdminister: Bool
    let defaultBranch: String
    let fileChanges: FileChanges?
    let mergeModel: IssueMergeModel?

    var timelineViewModels: [ListDiffable] {
        return timelinePages.reduce([], { $0 + $1.viewModels })
    }

    var minStartCursor: String? {
        return timelinePages.first?.startCursor
    }

    var hasPreviousPage: Bool {
        return minStartCursor != nil
    }

    func timelinePages(appending: [ListDiffable]) -> [IssueTimelinePage] {
        let newPage: IssueTimelinePage
        if let lastPage = timelinePages.last {
            newPage = IssueTimelinePage(
                startCursor: lastPage.startCursor,
                viewModels: lastPage.viewModels + appending
            )
        } else {
            newPage = IssueTimelinePage(
                startCursor: nil,
                viewModels: appending
            )
        }

        let count = timelinePages.count
        if count > 0 {
            return timelinePages[0..<count - 1] + [newPage]
        } else {
            return [newPage]
        }
    }

    func updated(
        id: String? = nil,
        pullRequest: Bool? = nil,
        title: StyledTextRenderer? = nil,
        labels: IssueLabelsModel? = nil,
        assignee: IssueAssigneesModel? = nil,
        timelinePages: [IssueTimelinePage]? = nil,
        viewerIsSubscribed: Bool? = nil,
        viewerCanUpdate: Bool? = nil,
        hasIssuesEnabled: Bool? = nil,
        viewerCanAdminister: Bool? = nil,
        defaultBranch: String? = nil,
        mergeModel: IssueMergeModel? = nil
        ) -> IssueResult {
        return IssueResult(
            id: id ?? self.id,
            pullRequest: pullRequest ?? self.pullRequest,
            title: title ?? self.title,
            labels: labels ?? self.labels,
            assignee: assignee ?? self.assignee,
            rootComment: self.rootComment,
            reviewers: self.reviewers,
            milestone: self.milestone,
            targetBranch: self.targetBranch,
            timelinePages: timelinePages ?? self.timelinePages,
            viewerIsSubscribed: viewerIsSubscribed ?? self.viewerIsSubscribed,
            viewerCanUpdate: viewerCanUpdate ?? self.viewerCanUpdate,
            hasIssuesEnabled: hasIssuesEnabled ?? self.hasIssuesEnabled,
            viewerCanAdminister: viewerCanAdminister ?? self.viewerCanAdminister,
            defaultBranch: defaultBranch ?? self.defaultBranch,
            fileChanges: fileChanges,
            mergeModel: mergeModel ?? self.mergeModel
        )
    }

    func withMilestone(
        _ milestone: Milestone?,
        timelinePages: [IssueTimelinePage]? = nil
        ) -> IssueResult {
        return IssueResult(
            id: self.id,
            pullRequest: self.pullRequest,
            title: self.title,
            labels: self.labels,
            assignee: self.assignee,
            rootComment: self.rootComment,
            reviewers: self.reviewers,
            milestone: milestone,
            targetBranch: self.targetBranch,
            timelinePages: timelinePages ?? self.timelinePages,
            viewerIsSubscribed: self.viewerIsSubscribed,
            viewerCanUpdate: self.viewerCanUpdate,
            hasIssuesEnabled: self.hasIssuesEnabled,
            viewerCanAdminister: self.viewerCanAdminister,
            defaultBranch: self.defaultBranch,
            fileChanges: self.fileChanges,
            mergeModel: self.mergeModel
        )
    }

    func withReviewers(
        _ reviewers: IssueAssigneesModel?,
        timelinePages: [IssueTimelinePage]? = nil
        ) -> IssueResult {
        return IssueResult(
            id: self.id,
            pullRequest: self.pullRequest,
            title: self.title,
            labels: self.labels,
            assignee: self.assignee,
            rootComment: self.rootComment,
            reviewers: reviewers,
            milestone: self.milestone,
            targetBranch: self.targetBranch,
            timelinePages: timelinePages ?? self.timelinePages,
            viewerIsSubscribed: self.viewerIsSubscribed,
            viewerCanUpdate: self.viewerCanUpdate,
            hasIssuesEnabled: self.hasIssuesEnabled,
            viewerCanAdminister: self.viewerCanAdminister,
            defaultBranch: self.defaultBranch,
            fileChanges: self.fileChanges,
            mergeModel: self.mergeModel
        )
    }

}

struct IssueTimelinePage {
    let startCursor: String?
    let viewModels: [ListDiffable]
}
