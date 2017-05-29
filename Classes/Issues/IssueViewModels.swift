//
//  IssueViewModels.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

private func createViewModels(_ issue: Issue, width: CGFloat) -> [IGListDiffable] {
    var result = [IGListDiffable]()
    result.append(createIssueTitleString(issue: issue, width: width))

    result.append(IssueLabelsModel(labels: issue.labels ?? []))

    if let root = createRootIssueComment(issue: issue, width: width) {
        result.append(root)
    }

    return result
}

func createViewModels(issue: Issue, width: CGFloat, completion: @escaping ([IGListDiffable]) -> ()) {
    DispatchQueue.global().async {
        let result = createViewModels(issue, width: width)
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

func createIssueTitleString(issue: Issue, width: CGFloat) -> NSAttributedStringSizing {
    let attributedString = NSAttributedString(
        string: issue.title ?? "",
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

func collapsedBodyInfo(bodies: [AnyObject]) -> (AnyObject, CGFloat)? {
    let cap: CGFloat = 300
    // minimum height to collapse so expanding shows significant amount of content
    let minDelta = CollapseCellMinHeight * 3

    var totalHeight: CGFloat = 0
    for body in bodies {
        let height = bodyHeight(viewModel: body)
        totalHeight += height
        if totalHeight > cap, totalHeight - cap > minDelta {
            let collapsedBodyHeight = max(cap - (totalHeight - height), CollapseCellMinHeight)
            return (body, collapsedBodyHeight)
        }
    }
    return nil
}

func createRootIssueComment(issue: Issue, width: CGFloat) -> IssueCommentModel? {
    guard let id = issue.id?.intValue,
        let created = issue.created_at,
        let date = GithubAPIDateFormatter().date(from: created),
        let login = issue.user?.login,
        let avatar = issue.user?.avatar_url,
        let avatarURL = URL(string: avatar)
        else { return nil }

    let details = IssueCommentDetailsViewModel(date: date, login: login, avatarURL: avatarURL)
    let bodies = createCommentModels(body: issue.body ?? "", width: width)
    let collapse = collapsedBodyInfo(bodies: bodies)
    return IssueCommentModel(id: id, details: details, bodyModels: bodies, collapse: collapse)
}
