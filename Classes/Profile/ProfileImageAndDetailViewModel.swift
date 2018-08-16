//
//  ProfileImageAndDetailViewModel.swift
//  Freetime
//
//  Created by B_Litwin on 8/16/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

final class ProfileImageAndDetailViewModel: ListDiffable {
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
    
    func diffIdentifier() -> NSObjectProtocol {
        return login as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? ProfileImageAndDetailViewModel else { return false }
        return avatarURL == object.avatarURL
            && login == object.login
            && name == object.name
    }
}
