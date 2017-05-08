//
//  LoginRequest.swift
//  Gitter
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

func requestGithubLogin(
    username: String,
    password: String,
    twoFactorCode: String? = nil,
    completion: @escaping (GithubLogin) -> ()
    ) {
    let parameters: [String: Any] = [
        "scopes": ["repo"],
        "note": "Gitter project manager for iOS",
        "client_id": GithubAPI.clientID,
        "client_secret": GithubAPI.clientSecret
    ]

    let base64Auth = "\(username):\(password)".data(using: .ascii)?.base64EncodedString() ?? ""
    var headers = [
        "Authorization": "Basic " + base64Auth
    ]
    if let code = twoFactorCode {
        headers["X-GitHub-OTP"] = code
    }

    let _ = requestGithub(
        path: "https://api.github.com/authorizations",
        method: .post,
        parameters: parameters,
        headers: headers) { response in
            if let twoFactorHeader = response.response?.allHeaderFields["X-GitHub-OTP"] as? String,
                twoFactorHeader.hasPrefix("required") {
                completion(.twoFactor)
            } else if let json = response.value as? [String: Any],
                let authorization = Authorization(json: json) {
                completion(.success(authorization))
            } else {
                completion(.failed(response.error))
            }
    }
}
