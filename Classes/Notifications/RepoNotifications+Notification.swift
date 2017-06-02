//
//  RepoNotifications+Notification.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func createNotificationViewModels(containerWidth: CGFloat, notifications: [Notification]) -> [NotificationViewModel] {
    var viewModels = [NotificationViewModel]()

    let df = GithubAPIDateFormatter()
    for notification in notifications {
        guard let type = NotificationType(rawValue: notification.subject.type),
            let date = df.date(from: notification.updated_at),
            let number = (notification.subject.url.components(separatedBy: "/").last as NSString?)?.integerValue
            else { continue }

        let model = NotificationViewModel(
            id: notification.id,
            title: notification.subject.title,
            type: type,
            date: date,
            read: !notification.unread,
            owner: notification.repository.owner.login,
            repo: notification.repository.name,
            number: number,
            containerWidth: containerWidth
        )
        viewModels.append(model)
    }

    return viewModels
}
