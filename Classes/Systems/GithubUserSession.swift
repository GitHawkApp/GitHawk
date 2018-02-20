//
//  GithubUserSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class GithubUserSession: NSObject, NSCoding {

    enum Keys {
        static let token = "token"
        static let authMethod = "authMethod"
        static let username = "username"
        static let enterpriseURL = "enterpriseURL"
    }

    enum AuthMethod: String {
        case oauth, pat
    }

    let token: String
    let authMethod: AuthMethod

    // mutable to handle migration from time when username wasn't captured
    // can freely mutate and manually update. caller must then save updated session.
    var username: String?
    let enterpriseURL: String?

    init(
        token: String,
        authMethod: AuthMethod,
        username: String?,
        enterpriseURL: String? = nil
        ) {
        self.token = token
        self.authMethod = authMethod
        self.username = username
        self.enterpriseURL = enterpriseURL
    }

    // MARK: NSCoding

    convenience init?(coder aDecoder: NSCoder) {
        guard let token = aDecoder.decodeObject(forKey: Keys.token) as? String
            else { return nil }

        let storedAuthMethod = aDecoder.decodeObject(forKey: Keys.authMethod) as? String
        let authMethod = storedAuthMethod.flatMap(AuthMethod.init) ?? .oauth

        let username = aDecoder.decodeObject(forKey: Keys.username) as? String
        let enterpriseURL = aDecoder.decodeObject(forKey: Keys.enterpriseURL) as? String

        self.init(
            token: token,
            authMethod: authMethod,
            username: username,
            enterpriseURL: enterpriseURL
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: Keys.token)
        aCoder.encode(authMethod.rawValue, forKey: Keys.authMethod)
        aCoder.encode(username, forKey: Keys.username)
        aCoder.encode(enterpriseURL, forKey: Keys.enterpriseURL)
    }

}
