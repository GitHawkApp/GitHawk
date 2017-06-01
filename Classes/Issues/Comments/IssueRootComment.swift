//
//  IssueRootComment.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func IssueCreateRootCommentModel(issue: Issue, width: CGFloat) -> IssueCommentModel? {
    guard let id = issue.id?.intValue,
        let created = issue.created_at,
        let date = GithubAPIDateFormatter().date(from: created),
        let login = issue.user?.login,
        let avatar = issue.user?.avatar_url,
        let avatarURL = URL(string: avatar)
        else { return nil }

    let details = IssueCommentDetailsViewModel(date: date, login: login, avatarURL: avatarURL)
    let bodies = createCommentModels(body: issue.body ?? "", width: width)
    let collapse = IssueCollapsedBodies(bodies: bodies)
    return IssueCommentModel(id: id, details: details, bodyModels: bodies, collapse: collapse)
}
