//
//  Alamofire+GithubAPI.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire
import Apollo

func newGithubClient(
    sessionManager: GithubSessionManager,
    userSession: GithubUserSession? = nil
    ) -> GithubClient {
    let config = URLSessionConfiguration.default
    // disable URL caching for the v3 API
    config.urlCache = nil
    config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    let networker = Alamofire.SessionManager(configuration: config)

    let gqlURL = URL(string: "https://api.github.com/graphql")!
    let apollo = ApolloClient(networkTransport: HTTPNetworkTransport(url: gqlURL, configuration: config))

    return GithubClient(
        sessionManager: sessionManager,
        apollo: apollo,
        networker: networker,
        userSession: userSession
    )
}
