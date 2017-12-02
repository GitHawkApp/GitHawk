//
//  GithubUserSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class Client: NSObject, NSCoding {
    
    enum Keys {
        static let type = "type"
        static let baseUrl = "baseUrl"
    }
    
    enum ClientType: String {
        case github
        case githubEnterprise
    }
    
    let type: ClientType
    let baseUrl: String
    
    override init() {
        self.type = .github
        self.baseUrl = "https://github.com/"
        super.init()
    }
    
    init(type: ClientType = .githubEnterprise, baseUrl: String) {
        self.type = type
        self.baseUrl = baseUrl
    }
    
    // MARK: NSCoding
    
    convenience init?(coder aDecoder: NSCoder) {
        let storedType = aDecoder.decodeObject(forKey: Keys.type) as? String
        
        let type = storedType.flatMap(ClientType.init) ?? .github
        guard let baseUrl = aDecoder.decodeObject(forKey: Keys.baseUrl) as? String else {
            return nil
        }
        
        self.init(type: type, baseUrl: baseUrl)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(type.rawValue, forKey: Keys.type)
        aCoder.encode(baseUrl, forKey: Keys.baseUrl)
    }
    
}

final class GithubUserSession: NSObject, NSCoding {
    
    enum Keys {
        static let token = "token"
        static let authMethod = "authMethod"
        static let username = "username"
        static let client = "client"
    }

    enum AuthMethod: String {
        case oauth, pat
    }

    let token: String
    let authMethod: AuthMethod
    let client: Client

    // mutable to handle migration from time when username wasn't captured
    // can freely mutate and manually update. caller must then save updated session.
    var username: String?

    init(
        token: String,
        authMethod: AuthMethod,
        username: String?,
        client: Client = Client() // Defaults to GitHub.com
        ) {
        self.token = token
        self.authMethod = authMethod
        self.username = username
        self.client = client
    }

    // MARK: NSCoding

    convenience init?(coder aDecoder: NSCoder) {
        guard let token = aDecoder.decodeObject(forKey: Keys.token) as? String
            else { return nil }

        let storedAuthMethod = aDecoder.decodeObject(forKey: Keys.authMethod) as? String
        let authMethod = storedAuthMethod.flatMap(AuthMethod.init) ?? .oauth

        let username = aDecoder.decodeObject(forKey: Keys.username) as? String
        let client = aDecoder.decodeObject(of: Client.self, forKey: Keys.client) ?? Client()

        self.init(
            token: token,
            authMethod: authMethod,
            username: username,
            client: client
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: Keys.token)
        aCoder.encode(authMethod.rawValue, forKey: Keys.authMethod)
        aCoder.encode(username, forKey: Keys.username)
        aCoder.encode(client, forKey: Keys.client)
    }

}
