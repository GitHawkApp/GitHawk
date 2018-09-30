//
//  Notification+NotificationViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import GitHubAPI
import FlatCache

func CreateNotificationViewModels(
    width: CGFloat,
    contentSizeCategory: UIContentSizeCategory,
    v3notifications: [V3Notification],
    cache: FlatCache,
    completion: @escaping ([NotificationViewModel]) -> Void
    ) {
    
    var models = [NotificationViewModel]()
    
    var cachedModels = [NotificationViewModel]()
    
    let uncachedV3Notifications: [V3Notification] = v3notifications.compactMap {
        if let model: NotificationViewModel = cache.get(id: $0.id) {
            cachedModels.append(model)
            return nil
        }
        return $0
    }
    
    var newModels = [NotificationViewModel]()
    
    DispatchQueue.global().async {
        
        for v3notification in uncachedV3Notifications {
            
            guard
                let type = NotificationType(rawValue: v3notification.subject.type.rawValue),
                let identifier = v3notification.subject.identifier else {
                    return
            }
            
            let number: NotificationViewModel.Number
            switch identifier {
            case .hash(let h): number = .hash(h)
            case .number(let n): number = .number(n)
            case .release(let r): number = .release(r)
            }
            
            let model = NotificationViewModel(
                v3id: v3notification.id,
                repo: v3notification.repository.name,
                owner: v3notification.repository.owner.login,
                title: CreateNotification(title: v3notification.subject.title, width: width, contentSizeCategory: contentSizeCategory),
                number: number,
                state: .pending, // fetched later
                date: v3notification.updatedAt,
                ago: v3notification.updatedAt.agoString(.short),
                read: !v3notification.unread,
                comments: 0, // fetched later
                watching: true, // assumed based on receiving
                type: type,
                // TODO get from GQL notification request
                branch: "master",
                issuesEnabled: true
            )
            
            newModels.append(model)
        }
        
        DispatchQueue.main.async {
            models.append(contentsOf: cachedModels)
            models.append(contentsOf: newModels)
            completion(models)
        }
    }

}
