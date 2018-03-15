//
//  GitHubUserSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public class GitHubUserSession: NSObject, NSCoding {

    enum Keys {
        static let token = "token"
        static let authMethod = "authMethod"
        static let username = "username"
    }

    public enum AuthMethod: String {
        case oauth, pat
    }

    public let token: String
    public let authMethod: AuthMethod

    // mutable to handle migration from time when username wasn't captured
    // can freely mutate and manually update. caller must then save updated session.
    public var username: String?

    public init(
        token: String,
        authMethod: AuthMethod,
        username: String?
        ) {
        self.token = token
        self.authMethod = authMethod
        self.username = username
    }

    // MARK: NSCoding

    public convenience required init?(coder aDecoder: NSCoder) {
        guard let token = aDecoder.decodeObject(forKey: Keys.token) as? String
            else { return nil }

        let storedAuthMethod = aDecoder.decodeObject(forKey: Keys.authMethod) as? String
        let authMethod = storedAuthMethod.flatMap(AuthMethod.init) ?? .oauth

        let username = aDecoder.decodeObject(forKey: Keys.username) as? String

        self.init(
            token: token,
            authMethod: authMethod,
            username: username
        )
    }

    public func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: Keys.token)
        aCoder.encode(authMethod.rawValue, forKey: Keys.authMethod)
        aCoder.encode(username, forKey: Keys.username)
    }

}
