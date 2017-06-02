//
//  GithubUserSession.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/17/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class GithubUserSession: NSObject, NSCoding {

    struct Keys {
        static let authorization = "authorization"
        static let login = "login"
    }

    let authorization: Authorization
    let login: String

    init(
        authorization: Authorization,
        login: String
        ) {
        self.authorization = authorization
        self.login = login
    }

    // MARK: NSCoding

    convenience init?(coder aDecoder: NSCoder) {
        guard let authorization = aDecoder.decodeObject(forKey: Keys.authorization) as? Authorization,
            let login = aDecoder.decodeObject(forKey: Keys.login) as? String
            else { return nil }
        self.init(
            authorization: authorization,
            login: login
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(authorization, forKey: Keys.authorization)
        aCoder.encode(login, forKey: Keys.login)
    }

}
