//
//  NotificationNavigation.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/28/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

func NavigateToNotificationContent(object: NotificationViewModel, client: GithubClient) -> UIViewController {
    switch object.identifier {
    case .hash(let hash):
        let url = URL(string: "https://github.com/\(object.owner)/\(object.repo)/commit/\(hash)")!
        return SFSafariViewController(url: url)
    case .number(let number):
        let model = IssueDetailsModel(owner: object.owner, repo: object.repo, number: number)
        let controller = IssuesViewController(
            client: client,
            model: model
        )
        return UINavigationController(rootViewController: controller)
    }
}
