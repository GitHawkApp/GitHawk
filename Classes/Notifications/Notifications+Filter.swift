//
//  Notifications+Filter.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func filter(notifications: [NotificationViewModel], unread: Bool = false) -> [NotificationViewModel] {
    if unread {
        var unreadNotifications = [NotificationViewModel]()
        for notification in notifications {
            if !notification.read {
                unreadNotifications.append(notification)
            }
        }
        return unreadNotifications
    } else {
        return notifications
    }
}
