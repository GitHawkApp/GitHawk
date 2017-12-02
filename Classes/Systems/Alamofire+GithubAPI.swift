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
    var additionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

    // for apollo + github gql endpoint
    // http://dev.apollodata.com/ios/initialization.html
    if let token = userSession?.token, let authMethod = userSession?.authMethod {
        let header = authMethod == .oauth ? "Bearer \(token)" : "token \(token)"
        additionalHeaders["Authorization"] = header
    }

    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = additionalHeaders
    config.timeoutIntervalForRequest = 15

    // disable URL caching for the v3 API
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil

    let networker = Alamofire.SessionManager(configuration: config)
    
    let client = userSession?.client ?? Client()
    let gqlURL = URL(string: client.graphQLUrl)!
    let transport = HTTPNetworkTransport(url: gqlURL, configuration: config)
    let apollo = ApolloClient(networkTransport: transport)

    return GithubClient(
        sessionManager: sessionManager,
        apollo: apollo,
        networker: networker,
        userSession: userSession
    )
}
