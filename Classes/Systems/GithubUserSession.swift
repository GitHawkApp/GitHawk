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
    }

    enum AuthMethod: String {
        case oauth = "oauth"
        case pat = "pat" // personal access token
    }

    let token: String
    let authMethod: AuthMethod

    init(
        token: String,
        authMethod: AuthMethod
        ) {
        self.token = token
        self.authMethod = authMethod
    }

    // MARK: NSCoding

    convenience init?(coder aDecoder: NSCoder) {
        guard let token = aDecoder.decodeObject(forKey: Keys.token) as? String
            else { return nil }

        let storedAuthMethod = aDecoder.decodeObject(forKey: Keys.authMethod) as? String
        let authMethod = storedAuthMethod.flatMap(AuthMethod.init) ?? .oauth

        self.init(
            token: token,
            authMethod: authMethod
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: Keys.token)
        aCoder.encode(authMethod.rawValue, forKey: Keys.authMethod)
    }

}
