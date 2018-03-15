//
//  IssueType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import UIKit

struct FileChanges: Equatable {
    let additions: Int
    let deletions: Int
    let changedFiles: Int

    static func == (lhs: FileChanges, rhs: FileChanges) -> Bool {
        return lhs.additions == rhs.additions
        && lhs.deletions == rhs.deletions
        && lhs.changedFiles == rhs.changedFiles
    }
}

protocol IssueType {

    var id: String { get }
    var pullRequest: Bool { get }
    var number: Int { get }
    var title: String { get }
    var labelableFields: LabelableFields { get }
    var commentFields: CommentFields { get }
    var reactionFields: ReactionFields { get }
    var closableFields: ClosableFields { get }
    var assigneeFields: AssigneeFields { get }
    var milestoneFields: MilestoneFields? { get }
    var merged: Bool { get }
    var locked: Bool { get }
    var headPaging: HeadPaging { get }
    var viewerCanUpdate: Bool { get }
    var fileChanges: FileChanges? { get }

    var reviewRequestModel: IssueAssigneesModel? { get }
    var mergeModel: IssueMergeModel? { get }

    func timelineViewModels(
        owner: String,
        repo: String,
        width: CGFloat
        ) -> (models: [ListDiffable], mentionedUsers: [AutocompleteUser])

}
