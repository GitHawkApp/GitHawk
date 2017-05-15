//
//  RepoNotifications+Filter.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func filter(repoNotifications: [RepoNotifications], unread: Bool = false) -> [RepoNotifications] {
    if unread {
        var unreadRepos = [RepoNotifications]()
        for repo in repoNotifications {
            var unreadNotifications = [NotificationViewModel]()
            for notification in repo.notifications {
                if !notification.read {
                    unreadNotifications.append(notification)
                }
            }
            if unreadNotifications.count > 0 {
                unreadRepos.append(RepoNotifications(repoName: repo.repoName, notifications: unreadNotifications))
            }
        }
        return unreadRepos
    } else {
        return repoNotifications
    }
}
