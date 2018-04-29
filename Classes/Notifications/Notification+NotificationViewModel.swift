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
            containerWidth: containerWidth
        )
        viewModels.append(model)
    }

    return viewModels
}
