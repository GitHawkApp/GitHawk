//
//  IssueResult.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

struct IssueResult {

    let subjectId: String
    let pullRequest: Bool

    let status: IssueStatusModel
    let title: NSAttributedStringSizing
    let labels: IssueLabelsModel
    let assignee: IssueAssigneesModel
    let rootComment: IssueCommentModel?
    let reviewers: IssueAssigneesModel?
    let milestone: IssueMilestoneModel?
    let mentionableUsers: [AutocompleteUser]
    let timelinePages: [IssueTimelinePage]
    let viewerCanUpdate: Bool
    let hasIssuesEnabled: Bool

    var timelineViewModels: [ListDiffable] {
        return timelinePages.reduce([], { $0 + $1.viewModels })
    }

    var minStartCursor: String? {
        return timelinePages.first?.startCursor
    }

    var hasPreviousPage: Bool {
        return minStartCursor != nil
    }

}

struct IssueTimelinePage {
    let startCursor: String?
    let viewModels: [ListDiffable]
}
