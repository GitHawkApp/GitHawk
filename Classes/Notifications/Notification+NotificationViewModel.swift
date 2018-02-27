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
        let type = split[split.count - 2]
        switch type {
        case "commits":
            return .hash(identifier)
        case "releases":
            return .release(identifier)
        default:
            return .number((identifier as NSString).integerValue)
        }
    }

}

func CreateViewModels(
    containerWidth: CGFloat,
    notifications: [NotificationResponse]) -> [NotificationViewModel] {
    var viewModels = [NotificationViewModel]()

    for notification in notifications {
        guard let type = NotificationType(rawValue: notification.subject.type),
            let date = notification.updated_at.githubDate,
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
    notifications: [NotificationResponse],
    completion: @escaping ([NotificationViewModel]) -> Void
    ) {
    DispatchQueue.global().async {
        let viewModels = CreateViewModels(containerWidth: containerWidth, notifications: notifications)
        DispatchQueue.main.async {
            completion(viewModels)
        }
    }
}
