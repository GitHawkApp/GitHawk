//
//  RepoNotifications+Fake.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/15/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

func fakeNotifications(width: CGFloat) -> [RepoNotifications] {
    return [
        RepoNotifications(repoName: "rnystrom/Fake1", notifications: [
            NotificationViewModel(
                title: "Lorem ipsum dolor sit er elit lamet consectetaur cillium adipisicing pecu",
                type: .issue,
                date: Date(timeIntervalSinceNow: -1),
                read: true,
                containerWidth: width
            ),
            NotificationViewModel(
                title: "Duis aute irure dolor",
                type: .issue,
                date: Date(timeIntervalSinceNow: -3600),
                read: false,
                containerWidth: width
            ),
            NotificationViewModel(
                title: "Excepteur sint occaecat cupidatat non proident",
                type: .issue,
                date: Date(timeIntervalSinceNow: -86500),
                read: true,
                containerWidth: width
            ),
            ]),
        RepoNotifications(repoName: "Repo 2", notifications: [
            NotificationViewModel(
                title: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
                type: .issue,
                date: Date(timeIntervalSinceNow: -259300),
                read: true,
                containerWidth: width
            ),
            NotificationViewModel(
                title: "Ullamco laboris nisi ut aliquip ex ea commodo",
                type: .issue,
                date: Date(timeIntervalSinceNow: -8640000),
                read: true,
                containerWidth: width
            ),
            ])
    ]
}
