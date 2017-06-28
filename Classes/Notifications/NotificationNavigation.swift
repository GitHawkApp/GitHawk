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
        let controller = IssuesViewController(
            client: client,
            owner: object.owner,
            repo: object.repo,
            number: number
        )
        return UINavigationController(rootViewController: controller)
    }
}
