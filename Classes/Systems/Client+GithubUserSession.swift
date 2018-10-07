//
//  Client+GithubUserSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/6/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubSession
import GitHubAPI

extension Client {

    static func make(userSession: GitHubUserSession? = nil) -> Client {
        let networkingConfigs = userSession?.networkingConfigs
        let config = ConfiguredNetworkers(
            token: networkingConfigs?.token,
            useOauth: networkingConfigs?.useOauth
        )
        return Client(
            httpPerformer: config.alamofire,
            apollo: config.apollo,
            token: userSession?.token
        )
    }

}
