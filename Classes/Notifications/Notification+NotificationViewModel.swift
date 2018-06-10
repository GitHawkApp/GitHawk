//
//  Notification+NotificationViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

import GitHubAPI

func CreateViewModels(
    containerWidth: CGFloat,
    contentSizeCategory: UIContentSizeCategory,
    v3notifications: [V3Notification]) -> [NotificationViewModel] {
    var viewModels = [NotificationViewModel]()

    for notification in v3notifications {
        guard let type = NotificationType(rawValue: notification.subject.type.rawValue),
            let identifier = notification.subject.identifier
            else { continue }

        let modelIdentifier: NotificationViewModel.Identifier
        switch identifier {
        case .hash(let h): modelIdentifier = .hash(h)
        case .number(let n): modelIdentifier = .number(n)
        case .release(let r): modelIdentifier = .release(r)
        }

        let model = NotificationViewModel(
            id: notification.id,
            title: notification.subject.title,
            type: type,
            date: notification.updatedAt,
            read: !notification.unread,
            owner: notification.repository.owner.login,
            repo: notification.repository.name,
            identifier: modelIdentifier,
            containerWidth: containerWidth,
            contentSizeCategory: contentSizeCategory
        )
        viewModels.append(model)
    }

    return viewModels
}

func CreateNotificationViewModels(
    width: CGFloat,
    contentSizeCategory: UIContentSizeCategory,
    v3notifications: [V3Notification]) -> [NotificationViewModel2] {
    var models = [NotificationViewModel2]()

    for notification in v3notifications {
        guard let type = NotificationType(rawValue: notification.subject.type.rawValue),
            let identifier = notification.subject.identifier
            else { continue }

        let modelIdentifier: NotificationViewModel2.Identifier
        switch identifier {
        case .hash(let h): modelIdentifier = .hash(h)
        case .number(let n): modelIdentifier = .number(n)
        case .release(let r): modelIdentifier = .release(r)
        }

        models.append(NotificationViewModel2(
            v3id: notification.id,
            repo: notification.repository.name,
            owner: notification.repository.owner.login,
            title: CreateNotification(title: notification.subject.title, width: width, contentSizeCategory: contentSizeCategory),
            ident: modelIdentifier,
            state: .pending, // fetched later
            date: notification.updatedAt,
            ago: notification.updatedAt.agoString(.short),
            read: !notification.unread,
            comments: 0, // fetched later
            watching: true, // assumed based on receiving
            type: type,
            // TODO get from GQL notification request
            branch: "master",
            issuesEnabled: true
        ))
    }

    return models
}
