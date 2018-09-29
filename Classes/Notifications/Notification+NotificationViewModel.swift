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
    
    let models: [NotificationViewModel] = v3notifications.compactMap {
        
        guard
            let type = NotificationType(rawValue: $0.subject.type.rawValue),
            let identifier = $0.subject.identifier else {
                return nil
        }
        
        if let viewModel: NotificationViewModel = cache.get(id: $0.id) {
            return viewModel
        }
        
        let number: NotificationViewModel.Number
        switch identifier {
        case .hash(let h): number = .hash(h)
        case .number(let n): number = .number(n)
        case .release(let r): number = .release(r)
        }
        
        return NotificationViewModel(
            v3id: $0.id,
            repo: $0.repository.name,
            owner: $0.repository.owner.login,
            title: CreateNotification(title: $0.subject.title, width: width, contentSizeCategory: contentSizeCategory),
            number: number,
            state: .pending, // fetched later
            date: $0.updatedAt,
            ago: $0.updatedAt.agoString(.short),
            read: !$0.unread,
            comments: 0, // fetched later
            watching: true, // assumed based on receiving
            type: type,
            // TODO get from GQL notification request
            branch: "master",
            issuesEnabled: true
        )
    }
    
    completion(models)
    
}
