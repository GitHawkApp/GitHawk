//
//  IssueViewModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

func createViewModels(
    issue: IssueType,
    width: CGFloat
    ) -> [ListDiffable] {

    var result = [ListDiffable]()

    let status: IssueStatus = issue.merged ? .merged : issue.closableFields.closed ? .closed : .open
    result.append(IssueStatusModel(status: status, pullRequest: issue.pullRequest, locked: issue.locked))
    result.append(titleStringSizing(title: issue.title, width: width))
    result.append(IssueLabelsModel(labels: issue.labelableFields.issueLabelModels))

    if let root = createCommentModel(
        id: issue.id,
        commentFields: issue.commentFields,
        reactionFields: issue.reactionFields,
        width: width,
        threadState: .single
        ) {
        result.append(root)
    }

    result += issue.timelineViewModels(width: width)

    return result
}

func titleStringSizing(title: String, width: CGFloat) -> NSAttributedStringSizing {
    let attributedString = NSAttributedString(
        string: title,
        attributes: [
            NSFontAttributeName: Styles.Fonts.headline,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark.color
        ])
    return NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
        inset: IssueTitleCell.inset
    )
}

func createIssueReactions(reactions: ReactionFields) -> IssueCommentReactionViewModel {
    var models = [ReactionViewModel]()

    for group in reactions.reactionGroups ?? [] {
        // do not display reactions for 0 count
        let count = group.users.totalCount
        guard count > 0 else { continue }
        models.append(ReactionViewModel(content: group.content, count: count, viewerDidReact: group.viewerHasReacted))
    }

    return IssueCommentReactionViewModel(models: models)
}

func createCommentModel(
    id: String,
    commentFields: CommentFields,
    reactionFields: ReactionFields, 
    width: CGFloat,
    threadState: IssueCommentModel.ThreadState
    ) -> IssueCommentModel? {
    guard let author = commentFields.author,
        let date = GithubAPIDateFormatter().date(from: commentFields.createdAt),
        let avatarURL = URL(string: author.avatarUrl)
        else { return nil }

    let details = IssueCommentDetailsViewModel(
        date: date,
        login:
        author.login,
        avatarURL: avatarURL,
        didAuthor: commentFields.viewerDidAuthor
    )
    let bodies = CreateCommentModels(markdown: commentFields.body, width: width)
    let reactions = createIssueReactions(reactions: reactionFields)
    let collapse = IssueCollapsedBodies(bodies: bodies, width: width)
    return IssueCommentModel(
        id: id,
        details: details,
        bodyModels: bodies,
        reactions: reactions,
        collapse: collapse,
        threadState: threadState
    )
}
