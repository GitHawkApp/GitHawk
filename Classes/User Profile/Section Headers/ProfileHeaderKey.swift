//
//  HeaderKey.swift
//  Freetime
//
//  Created by B_Litwin on 8/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import UIKit
import IGListKit

class ProfileHeaderKey: ListDiffable {
    let title: String
    
    init(title: String) {
        self.title = title
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return (title + "HeaderViewModel") as NSObjectProtocol
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if let object = object as? ProfileHeaderKey {
            return object.title == title
        }
        return false
    }
}
