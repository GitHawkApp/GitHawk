//
//  IssueNotificationRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession
import GitHawkRoutes

extension IssueRoute: RoutePerformable {
    func perform(props: RoutePerformableProps) -> RoutePerformableResult {
        return .push(IssuesViewController(
            client: props.client,
            model: IssueDetailsModel(owner: owner, repo: repo, number: number),
            scrollToBottom: true
        ))
    }
}
