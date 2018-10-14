//
//  AppController+SetupRoutes.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/7/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

extension AppController {

    func setupRoutes() {
        register(route: BookmarkShortcutRoute.self)
        register(route: SwitchAccountShortcutRoute.self)
        register(route: SearchShortcutRoute.self)
        register(route: IssueNotificationRoute.self)
    }

}
