//
//  RepoNotifications+Notification.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func createRepoNotifications(containerWidth: CGFloat, notifications: [Notification]) -> [RepoNotifications] {
    var map = [String: [NotificationViewModel]]()

    let df = GithubAPIDateFormatter()
    for notification in notifications {
        guard let type = NotificationType(rawValue: notification.subject.type),
        let date = df.date(from: notification.updated_at)
            else { continue }

        let model = NotificationViewModel(
            title: notification.subject.title,
            type: type,
            date: date,
            read: !notification.unread,
            containerWidth: containerWidth
        )

        let key = notification.repository.owner.login + "/" + notification.repository.name
        var viewModels = map[key] ?? []
        viewModels.append(model)
        map[key] = viewModels
    }

    return map.map { RepoNotifications(repoName: $0, notifications: $1) }
}
