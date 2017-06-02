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
    _ issue: IssueQuery.Data.Repository.Issue,
    width: CGFloat
    ) -> [IGListDiffable] {
    var result = [IGListDiffable]()
    result.append(createIssueTitleString(issue: issue, width: width))

    var labels = [IssueLabelModel]()
    for node in issue.labels?.nodes ?? [] {
        guard let node = node else { continue }
        labels.append(IssueLabelModel(color: node.color, name: node.name))
    }
    result.append(IssueLabelsModel(labels: labels))

    if let root = createIssueRootCommentModel(issue: issue, width: width) {
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
        let result = createViewModels(issue, width: width)
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

func createIssueTitleString(
    issue: IssueQuery.Data.Repository.Issue,
    width: CGFloat
    ) -> NSAttributedStringSizing {
    let attributedString = NSAttributedString(
        string: issue.title,
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

func createIssueRootCommentModel(
    issue: IssueQuery.Data.Repository.Issue,
    width: CGFloat
    ) -> IssueCommentModel? {
    let commentFields = issue.fragments.commentFields

    guard let author = commentFields.author,
        let date = GithubAPIDateFormatter().date(from: commentFields.createdAt),
        let avatarURL = URL(string: author.avatarUrl)
        else { return nil }

    let details = IssueCommentDetailsViewModel(date: date, login: author.login, avatarURL: avatarURL)
    let bodies = createCommentModels(body: issue.fragments.commentFields.body, width: width)
    let reactions = createIssueReactions(reactions: issue.fragments.reactionFields)
    let collapse = IssueCollapsedBodies(bodies: bodies)
    return IssueCommentModel(
        id: issue.number,
        details: details,
        reactions: reactions,
        bodyModels: bodies,
        collapse: collapse
    )
}
