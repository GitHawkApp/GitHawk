//
//  GithubClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/16/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire
import Apollo
import FlatCache
import GitHubAPI
import GitHubSession

struct GithubClient {

    let userSession: GitHubUserSession?
    let cache = FlatCache()
    let bookmarksStore: BookmarkStore?
    let client: Client
    let badge: BadgeNotifications

    init(userSession: GitHubUserSession? = nil) {
        self.userSession = userSession

        self.client = Client.make(userSession: userSession)
        self.badge = BadgeNotifications(client: self.client)

        if let token = userSession?.token {
            self.bookmarksStore = BookmarkStore(token: token)
        } else {
            self.bookmarksStore = nil
        }
    }

}
