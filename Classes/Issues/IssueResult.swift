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
    let viewerCanUpdate: Bool
    let viewModels: [ListDiffable]
    let mentionableUsers: [AutocompleteUser]
    let timelinePages: [IssueTimelinePage]

    var allViewModels: [ListDiffable] {
        return viewModels + timelineViewModels
    }

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
