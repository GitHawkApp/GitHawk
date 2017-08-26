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

    enum AccessTokenResult {
        case failure
        case success(AccessTokenUser)
    }

    func requestAccessToken(
        code: String,
        completion: @escaping (AccessTokenResult) -> ()
        ) {
        let parameters = [
            "code": code,
            "client_id": GithubAPI.clientID,
            "client_secret": GithubAPI.clientSecret,
        ]
        let headers = [
            "Accept": "application/json"
        ]
        request(Request(
            url: "https://github.com/login/oauth/access_token",
            method: .post,
            parameters: parameters,
            headers: headers,
            completion: { (response, _) in
            if let json = response.value as? [String: Any],
                let token = json["access_token"] as? String {
                self.verifyPersonalAccessToken(token: token, completion: { result in
                    switch result {
                    case .success(let user): completion(.success(user))
                    case .failure: completion(.failure)
                    }
                })
            } else {
                completion(.failure)
            }
        }))
    }

    func verifyPersonalAccessToken(
        token: String,
        completion: @escaping (AccessTokenResult) -> ()
        ) {
        let headers = [
            "Accept": "application/json",
            "Authorization": "token \(token)"
        ]
        request(Request(
            url: "https://api.github.com/user",
            method: .get,
            headers: headers,
            completion: { (response, _) in
                if let json = response.value as? [String: Any],
                    let username = json["login"] as? String {
                    completion(.success(AccessTokenUser(token: token, username: username)))
                } else {
                    completion(.failure)
                }
        }))
    }
}
