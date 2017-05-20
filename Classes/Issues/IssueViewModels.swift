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

func createIssueCommentStrings(issue: Issue, width: CGFloat) -> [NSAttributedStringSizing] {
    let attributedString = NSAttributedString(
        string: issue.body ?? "",
        attributes: [
            NSFontAttributeName: Styles.Fonts.body,
            NSForegroundColorAttributeName: Styles.Colors.Gray.dark
        ])
    return [ NSAttributedStringSizing(
        containerWidth: width,
        attributedText: attributedString,
        inset: IssueCommentTextCell.inset
    ) ]
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
    let bodies = createIssueCommentStrings(issue: issue, width: width)
    return IssueCommentModel(id: id, details: details, bodyModels: bodies)
}
