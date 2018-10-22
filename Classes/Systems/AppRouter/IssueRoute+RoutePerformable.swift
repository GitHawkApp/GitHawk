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
    func perform(
        sessionManager: GitHubSessionManager,
        splitViewController: AppSplitViewController,
        client: GithubClient
        ) -> Bool {
        let model = IssueDetailsModel(owner: owner, repo: repo, number: number)
        let controller = IssuesViewController(client: client, model: model, scrollToBottom: true)
        splitViewController.showDetailViewController(controller, sender: nil)
        return true
    }
}
