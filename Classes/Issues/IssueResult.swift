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

struct IssueResult: Cachable {

    let id: String
    let pullRequest: Bool
    let status: IssueStatusModel
    let title: NSAttributedStringSizing
    let labels: IssueLabelsModel
    let assignee: IssueAssigneesModel
    let rootComment: IssueCommentModel?
    let reviewers: IssueAssigneesModel?
    let milestone: IssueMilestoneModel?
    let timelinePages: [IssueTimelinePage]
    let viewerCanUpdate: Bool
    let hasIssuesEnabled: Bool
    let viewerCanAdminister: Bool
    let defaultBranch: String

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
        status: IssueStatusModel? = nil,
        title: NSAttributedStringSizing? = nil,
        labels: IssueLabelsModel? = nil,
        assignee: IssueAssigneesModel? = nil,
        rootComment: IssueCommentModel? = nil,
        reviewers: IssueAssigneesModel? = nil,
        milestone: IssueMilestoneModel? = nil,
        timelinePages: [IssueTimelinePage]? = nil,
        viewerCanUpdate: Bool? = nil,
        hasIssuesEnabled: Bool? = nil,
        viewerCanAdminister: Bool? = nil,
        defaultBranch: String? = nil
        ) -> IssueResult {
        return IssueResult(
            id: id ?? self.id,
            pullRequest: pullRequest ?? self.pullRequest,
            status: status ?? self.status,
            title: title ?? self.title,
            labels: labels ?? self.labels,
            assignee: assignee ?? self.assignee,
            rootComment: rootComment ?? self.rootComment,
            reviewers: reviewers ?? self.reviewers,
            milestone: milestone ?? self.milestone,
            timelinePages: timelinePages ?? self.timelinePages,
            viewerCanUpdate: viewerCanUpdate ?? self.viewerCanUpdate,
            hasIssuesEnabled: hasIssuesEnabled ?? self.hasIssuesEnabled,
            viewerCanAdminister: viewerCanAdminister ?? self.viewerCanAdminister,
            defaultBranch: defaultBranch ?? self.defaultBranch
        )
    }

}

struct IssueTimelinePage {
    let startCursor: String?
    let viewModels: [ListDiffable]
}
