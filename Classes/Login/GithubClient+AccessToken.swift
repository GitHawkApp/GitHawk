//
//  GithubClient+AccessToken.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension GithubClient {

    struct AccessTokenUser {
        let token: String
        let username: String
    }

    func requestAccessToken(
        code: String,
        completion: @escaping (Result<AccessTokenUser>) -> Void
        ) {
        let parameters = [
            "code": code,
            "client_id": GithubAPI.clientID,
            "client_secret": GithubAPI.clientSecret
        ]
        let headers = [
            "Accept": "application/json"
        ]
        request(Request(
            url: "https://github.com/login/oauth/access_token",
            method: .post,
            parameters: parameters,
            headers: headers,
            logoutOnAuthFailure: false,
            completion: { (response, _) in
            if let json = response.value as? [String: Any],
                let token = json["access_token"] as? String {

                // after acquiring token, fetch the username so a complete user session can be stored
                self.verifyPersonalAccessToken(token: token, completion: { result in
                    switch result {
                    case .success(let user): completion(.success(user))
                    case .error: completion(.error(nil))
                    }
                })
            } else {
                completion(.error(nil))
            }
        }))
    }

    func verifyPersonalAccessToken(
        token: String,
        completion: @escaping (Result<AccessTokenUser>) -> Void
        ) {
        let headers = [
            "Accept": "application/json",
            "Authorization": "token \(token)"
        ]
        request(Request(
            url: "https://api.github.com/user",
            method: .get,
            headers: headers,
            logoutOnAuthFailure: false,
            completion: { (response, _) in
                if let json = response.value as? [String: Any],
                    let username = json["login"] as? String {
                    completion(.success(AccessTokenUser(token: token, username: username)))
                } else {
                    completion(.error(nil))
                }
        }))
    }
}
