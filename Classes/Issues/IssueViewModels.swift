//
//  IssueViewModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

private func createViewModels(
    number: Int,
    title: String,
    labelableFields: LabelableFields,
    commentFields: CommentFields,
    reactionFields: ReactionFields,
    width: CGFloat
    ) -> [IGListDiffable] {
    var result = [IGListDiffable]()
    result.append(titleStringSizing(title: title, width: width))

    let labels = labelableFields.issueLabelModels
    result.append(IssueLabelsModel(labels: labels))

    if let root = createCommentModel(
        number: number,
        commentFields: commentFields,
        reactionFields: reactionFields,
        width: width
        ) {
        result.append(root)
    }

    return result
}

func createViewModels(
    issue: IssueQuery.Data.Repository.Issue,
    width: CGFloat,
    completion: @escaping ([IGListDiffable]) -> ()
    ) {
    DispatchQueue.global().async {
        let result = createViewModels(
            number: issue.number,
            title: issue.title,
            labelableFields: issue.fragments.labelableFields,
            commentFields: issue.fragments.commentFields,
            reactionFields: issue.fragments.reactionFields,
            width: width
        )
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

func createViewModels(
    pullRequest: PullRequestQuery.Data.Repository.PullRequest,
    width: CGFloat,
    completion: @escaping ([IGListDiffable]) -> ()
    ) {
    DispatchQueue.global().async {
        let result = createViewModels(
            number: pullRequest.number,
            title: pullRequest.title,
            labelableFields: pullRequest.fragments.labelableFields,
            commentFields: pullRequest.fragments.commentFields,
            reactionFields: pullRequest.fragments.reactionFields,
            width: width
        )
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

func titleStringSizing(title: String, width: CGFloat) -> NSAttributedStringSizing {
    let attributedString = NSAttributedString(
        string: title,
        attributes: [
            NSFontAttributeName: Styles.Fonts.headline,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark
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
        models.append(ReactionViewModel(type: group.content.type, count: count, viewerDidReact: group.viewerHasReacted))
    }

    return IssueCommentReactionViewModel(models: models)
}

func createCommentModel(
    number: Int,
    commentFields: CommentFields,
    reactionFields: ReactionFields, 
    width: CGFloat
    ) -> IssueCommentModel? {
    guard let author = commentFields.author,
        let date = GithubAPIDateFormatter().date(from: commentFields.createdAt),
        let avatarURL = URL(string: author.avatarUrl)
        else { return nil }

    let details = IssueCommentDetailsViewModel(date: date, login: author.login, avatarURL: avatarURL)
    let bodies = createCommentModels(body: commentFields.body, width: width)
    let reactions = createIssueReactions(reactions: reactionFields)
    let collapse = IssueCollapsedBodies(bodies: bodies)
    return IssueCommentModel(
        number: number,
        details: details,
        bodyModels: bodies,
        reactions: reactions,
        collapse: collapse
    )
}
