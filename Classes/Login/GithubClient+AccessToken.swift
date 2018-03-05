//
//  GithubClient+AccessToken.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

import GitHubAPI

extension GithubClient {

    struct AccessTokenUser {
        let token: String
        let username: String
    }

    func requestAccessToken(
        code: String,
        completion: @escaping (Result<AccessTokenUser>) -> Void
        ) {
        client.send(GitHubAccessTokenRequest(
            code: code,
            clientId: Secrets.GitHub.clientId,
            clientSecret: Secrets.GitHub.clientSecret)
        ) { result in
            switch result {
            case .success(let response):
                self.verifyPersonalAccessToken(token: response.data.accessToken) { result2 in
                    switch result2 {
                    case .success(let user): completion(.success(user))
                    case .error(let error): completion(.error(error))
                    }
                }
            case .failure(let error):
                completion(.error(error))
            }
        }
    }

    func verifyPersonalAccessToken(
        token: String,
        completion: @escaping (Result<AccessTokenUser>) -> Void
        ) {
        client.send(V3VerifyPersonalAccessTokenRequest(token: token)) { result in
            switch result {
            case .success(let response):
                completion(.success(AccessTokenUser(token: token, username: response.data.login)))
            case .failure(let error):
                completion(.error(error))
            }
        }
    }
}
