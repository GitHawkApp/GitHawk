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
    private let bookmarkMigrator: BookmarkCloudMigrator?

    init(userSession: GitHubUserSession? = nil) {
        self.userSession = userSession

        self.client = Client.make(userSession: userSession)
        self.badge = BadgeNotifications(client: self.client)

        if let token = userSession?.token {
            let store = BookmarkStore(token: token)
            self.bookmarksStore = store
            self.bookmarkMigrator = BookmarkCloudMigrator(oldStore: store, client: self.client)
            self.bookmarkMigrator?.sync()
        } else {
            self.bookmarksStore = nil
            self.bookmarkMigrator = nil
        }
    }

}
