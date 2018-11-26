//
//  UNMutableNotificationContent+Routable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/9/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UserNotifications
import GitHawkRoutes

let UNNotificationContentRoutePathKey = "path"

extension UNMutableNotificationContent {

    func set<T: Routable>(route: T) {
        userInfo[UNNotificationContentRoutePathKey] = T.path
        route.encoded.forEach { userInfo[$0] = $1 }
    }

}
