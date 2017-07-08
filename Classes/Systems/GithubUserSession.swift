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
        static let token = "token"
    }

    let token: String

    init(
        token: String
        ) {
        self.token = token
    }

    // MARK: NSCoding

    convenience init?(coder aDecoder: NSCoder) {
        guard let token = aDecoder.decodeObject(forKey: Keys.token) as? String
            else { return nil }
        self.init(
            token: token
        )
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(token, forKey: Keys.token)
    }

}
