//
//  Notification+NotificationViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubAPI

func CreateNotificationViewModels(
    width: CGFloat,
    contentSizeCategory: UIContentSizeCategory,
    v3notifications: [V3Notification],
    completion: @escaping ([NotificationViewModel]) -> Void
    ) {
    DispatchQueue.global().async {
        var models = [NotificationViewModel]()

        for notification in v3notifications {
            guard let type = NotificationType(rawValue: notification.subject.type.rawValue)
                else { continue }
            let number: NotificationViewModel.Number
            
            if notification.subject.identifier != nil {
            guard let identifier = notification.subject.identifier
                else {continue}
                switch identifier {
                case .hash(let h): number = .hash(h)
                case .number(let n): number = .number(n)
                case .release(let r): number = .release(r)
                }
            } else {
                number = .number(1)
            }
            models.append(NotificationViewModel(
                v3id: notification.id,
                repo: notification.repository.name,
                owner: notification.repository.owner.login,
                title: CreateNotification(title: notification.subject.title, width: width, contentSizeCategory: contentSizeCategory),
                number: number,
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
        
        DispatchQueue.main.async {
            completion(models)
        }
    }
}
