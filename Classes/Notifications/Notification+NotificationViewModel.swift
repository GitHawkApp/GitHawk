//
//  Notification+NotificationViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension String {

    var notificationIdentifier: NotificationViewModel.Identifier? {
        let split = components(separatedBy: "/")
        guard split.count > 2,
            let identifier = split.last
            else { return nil }
        if split[split.count - 2] == "commits" {
            return .hash(identifier)
        } else {
            return .number((identifier as NSString).integerValue)
        }
    }

}

func CreateViewModels(
    containerWidth: CGFloat,
    notifications: [Notification]) -> [NotificationViewModel] {
    var viewModels = [NotificationViewModel]()

    let df = GithubAPIDateFormatter()
    for notification in notifications {
        guard let type = NotificationType(rawValue: notification.subject.type),
            let date = df.date(from: notification.updated_at),
            let identifier = notification.subject.url.notificationIdentifier
            else { continue }

        let model = NotificationViewModel(
            id: notification.id,
            title: notification.subject.title,
            type: type,
            date: date,
            read: !notification.unread,
            owner: notification.repository.owner.login,
            repo: notification.repository.name,
            identifier: identifier,
            containerWidth: containerWidth
        )
        viewModels.append(model)
    }

    return viewModels
}

func CreateNotificationViewModels(
    containerWidth: CGFloat,
    notifications: [Notification],
    completion: @escaping ([NotificationViewModel]) -> ()
    ) {
    DispatchQueue.global().async {
        var viewModels = [NotificationViewModel]()

        let df = GithubAPIDateFormatter()
        for notification in notifications {
            guard let type = NotificationType(rawValue: notification.subject.type),
                let date = df.date(from: notification.updated_at),
                let identifier = notification.subject.url.notificationIdentifier
                else { continue }

            let model = NotificationViewModel(
                id: notification.id,
                title: notification.subject.title,
                type: type,
                date: date,
                read: !notification.unread,
                owner: notification.repository.owner.login,
                repo: notification.repository.name,
                identifier: identifier,
                containerWidth: containerWidth
            )
            viewModels.append(model)
        }

        DispatchQueue.main.async {
            completion(viewModels)
        }
    }
}
