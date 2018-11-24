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
    let client: Client
    let badge: BadgeNotifications

    let bookmarkCloudStore: BookmarkIDCloudStore?

    init(userSession: GitHubUserSession? = nil) {
        self.userSession = userSession

        self.client = Client.make(userSession: userSession)
        self.badge = BadgeNotifications(client: self.client)

        if let username = userSession?.username {
            self.bookmarkCloudStore = BookmarkIDCloudStore(username: username)
        } else {
            self.bookmarkCloudStore = nil
        }
    }

}
