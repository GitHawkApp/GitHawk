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
import GitHubSession
import GitHubAPI

func newGithubClient(
    userSession: GitHubUserSession? = nil
    ) -> GithubClient {
    let networkingConfigs = userSession?.networkingConfigs
    let config = ConfiguredNetworkers(
        token: networkingConfigs?.token,
        useOauth: networkingConfigs?.useOauth
    )
    return GithubClient(
        apollo: config.apollo,
        networker: config.alamofire,
        userSession: userSession
    )
}
