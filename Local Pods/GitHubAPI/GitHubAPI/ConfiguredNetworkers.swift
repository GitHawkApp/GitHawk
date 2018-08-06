//
//  ConfiguredNetworkers.swift
//  FreetimeWatch Extension
//
//  Created by Ryan Nystrom on 4/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire
import Apollo

public func ConfiguredNetworkers(
    token: String?, useOauth: Bool?
    ) -> (alamofire: Alamofire.SessionManager, apollo: ApolloClient) {
    var additionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

    // for apollo + github gql endpoint
    // http://dev.apollodata.com/ios/initialization.html
    if let token = token, let useOauth = useOauth {
        let header = useOauth ? "Bearer \(token)" : "token \(token)"
        additionalHeaders["Authorization"] = header
    }

    // https://developer.github.com/v4/previews/#mergeinfopreview---more-detailed-information-about-a-pull-requests-merge-state
    additionalHeaders["Accept"] = "application/vnd.github.merge-info-preview+json"

    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = additionalHeaders
    config.timeoutIntervalForRequest = 15

    // disable URL caching for the v3 API
    config.requestCachePolicy = .reloadIgnoringLocalCacheData
    config.urlCache = nil

    let alamofire = Alamofire.SessionManager(configuration: config)

    let gqlURL = URL(string: "https://api.github.com/graphql")!
    let transport = HTTPNetworkTransport(url: gqlURL, configuration: config)
    let apollo = ApolloClient(networkTransport: transport)

    return (alamofire, apollo)
}
