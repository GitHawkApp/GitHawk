//
//  Alamofire+GithubAPI.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import Alamofire

func newGithubClient(
    sessionManager: GithubSessionManager,
    userSession: GithubUserSession? = nil
    ) -> GithubClient {
    let config = URLSessionConfiguration.default
    config.urlCache = nil
    config.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    let manager = Alamofire.SessionManager(configuration: config)
    return GithubClient(sessionManager: sessionManager, networker: manager, userSession: userSession)
}
