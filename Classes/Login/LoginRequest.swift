//
//  LoginRequest.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/7/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum GithubLogin {
    case failed(Error?)
    case success(Authorization)
    case twoFactor
}

private func base64Auth(username: String, password: String) -> String {
    return "Basic " + ("\(username):\(password)".data(using: .ascii)?.base64EncodedString() ?? "")
}

extension GithubClient {

    func requestGithubLogin(
        username: String,
        password: String,
        twoFactorCode: String? = nil,
        completion: @escaping (GithubLogin) -> ()
        ) {
        let parameters: [String: Any] = [
            "scopes": ["repo"],
            "note": "Freetime project manager for iOS",
            "client_id": GithubAPI.clientID,
            "client_secret": GithubAPI.clientSecret
        ]

        var headers = [
            "Authorization": base64Auth(username: username, password: password)
        ]
        if let code = twoFactorCode {
            headers["X-GitHub-OTP"] = code
        }

        request(Request(
            path: "authorizations",
            method: .post,
            parameters: parameters,
            headers: headers
        ) { response in
            if let twoFactorHeader = response.response?.allHeaderFields["X-GitHub-OTP"] as? String,
                twoFactorHeader.hasPrefix("required") {
                completion(.twoFactor)
            } else if let json = response.value as? [String: Any],
                let authorization = Authorization(json: json) {
                completion(.success(authorization))
            } else {
                completion(.failed(response.error))
            }
        })
    }

}
