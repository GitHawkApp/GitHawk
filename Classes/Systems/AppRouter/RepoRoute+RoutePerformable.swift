//
//  RepoRoute+RoutePerformable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/21/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHawkRoutes
import GitHubSession

extension RepoRoute: RoutePerformable {
    func perform(
        sessionManager: GitHubSessionManager,
        splitViewController: AppSplitViewController,
        client: GithubClient
        ) -> Bool {
        // TODO issues enabled should be fetched in the VC
        let model = RepositoryDetails(
            owner: owner,
            name: repo,
            defaultBranch: branch,
            hasIssuesEnabled: true
        )
        let controller = RepositoryViewController(client: client, repo: model)
        splitViewController.showDetailViewController(controller, sender: nil)
        return true
    }
}
