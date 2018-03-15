//
//  Client+AccessToken.swift
//  Freetime
//
//  Created by Ryan Nystrom on 3/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI

extension Client {

    struct AccessTokenUser {
        let token: String
        let username: String
    }

    func requestAccessToken(
        code: String,
        completion: @escaping (Result<AccessTokenUser>) -> Void
        ) {
        send(GitHubAccessTokenRequest(
            code: code,
            clientId: Secrets.GitHub.clientId,
            clientSecret: Secrets.GitHub.clientSecret)
        ) { [weak self] result in
            switch result {
            case .success(let response):
                self?.send(V3VerifyPersonalAccessTokenRequest(token: response.data.accessToken)) { result in
                    switch result {
                    case .success(let response2):
                        completion(.success(AccessTokenUser(token: response.data.accessToken, username: response2.data.login)))
                    case .failure(let error):
                        completion(.error(error))
                    }
                }
            case .failure(let error):
                completion(.error(error))
            }
        }
    }

}
