//
//  NotificationNavigation.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/28/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SafariServices

func NavigateToNotificationContent(
    object: NotificationViewModel,
    client: GithubClient,
    scrollToBottom: Bool = false
    ) -> UIViewController {
    switch object.identifier {
    case .hash(let hash):
        let url = URL(string: "https://github.com/\(object.owner)/\(object.repo)/commit/\(hash)")!
        return try! SFSafariViewController.configured(with: url)
    case .number(let number):
        let model = IssueDetailsModel(owner: object.owner, repo: object.repo, number: number)
        let controller = IssuesViewController(
            client: client,
            model: model,
            scrollToBottom: scrollToBottom
        )
        return UINavigationController(rootViewController: controller)
    }
}
