//
//  Label.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class RepositoryLabel: ListDiffable, Equatable {

    let color: String
    let name: String

    init(color: String, name: String) {
        self.color = color
        self.name = name
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return name as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? RepositoryLabel else { return false }
        return color == object.color
    }
    
    //MARK: Equatable
    
    static func ==(lhs: RepositoryLabel, rhs: RepositoryLabel) -> Bool {
        return lhs.name == rhs.name
            && lhs.color == rhs.color
    }

}
