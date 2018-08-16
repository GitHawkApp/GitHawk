//
//  UserProfileModel.swift
//  Freetime
//
//  Created by B_Litwin on 8/15/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit


final class UserProfileModel: ListDiffable {
    let avatarURL: String
    let login: String
    let name: String?
    let location: String?
    
    init(avatarURL: String,
         login: String,
         name: String?,
         location: String?
        ) {
        self.avatarURL = avatarURL
        self.login = login
        self.name = name
        self.location = location 
    }
    
    convenience init(_ user: UserQuery.Data.User) {
        self.init(avatarURL: user.avatarUrl,
                  login: user.login,
                  name: user.name,
                  location: user.location
        )
    }
    
    
    func diffIdentifier() -> NSObjectProtocol {
        return login as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? UserProfileModel else { return false }
        return login == object.login
            && avatarURL == object.avatarURL
            && name == object.name
    }
    
}
