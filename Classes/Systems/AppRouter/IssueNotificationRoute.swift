//
//  IssueNotificationRoute.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession

struct IssueNotificationRoute: Routable {
    let owner: String
    let repo: String
    let number: Int
    static func from(params: [String: String]) -> IssueNotificationRoute? {
        guard let owner = params["owner"],
            let repo = params["repo"],
            let number = (params["number"] as NSString?)?.integerValue
            else { return nil }
        return IssueNotificationRoute(owner: owner, repo: repo, number: number)
    }
    static var path: String {
        return "com.githawk.issue-notifications"
    }
    var encoded: [String: String] {
        return [
            "owner": owner,
            "repo": repo,
            "number": "\(number)"
        ]
    }
}

extension IssueNotificationRoute: RoutePerformable {
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
