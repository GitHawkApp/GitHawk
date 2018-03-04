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
import AlamofireNetworkActivityIndicator
import FlatCache
import GitHubAPI

struct GithubClient {

    private let sessionManager: GithubSessionManager

    let userSession: GithubUserSession?
    let cache = FlatCache()
    let bookmarksStore: BookmarkStore?
    let client: Client

    init(
        sessionManager: GithubSessionManager,
        apollo: ApolloClient,
        networker: Alamofire.SessionManager,
        userSession: GithubUserSession? = nil
        ) {
        self.sessionManager = sessionManager
        self.userSession = userSession

        self.client = Client(httpPerformer: networker, apollo: apollo, token: userSession?.token)

        if let token = userSession?.token {
            self.bookmarksStore = BookmarkStore(token: token)
        } else {
            self.bookmarksStore = nil
        }
    }

}
