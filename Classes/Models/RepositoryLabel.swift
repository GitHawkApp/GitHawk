//
//  Label.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class RepositoryLabel: ListDiffable, Hashable, Equatable, ListSwiftDiffable {

    let color: String
    var name: String = ""

    init(color: String, name: String) {
        self.color = color
        self.name = name.replacingGithubEmoji
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

    // MARK: Hashable

    public func hash(into hasher: inout Hasher) {
        hasher.combine(color.hashValue)
        hasher.combine(name.hashValue)
    }

    // MARK: Equatable

    static func == (lhs: RepositoryLabel, rhs: RepositoryLabel) -> Bool {
        if lhs === rhs { return true }
        return lhs.color == rhs.color
        && lhs.name == rhs.name
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return name
    }

    func isEqual(to object: ListSwiftDiffable) -> Bool {
        guard let object = object as? RepositoryLabel else { return false }
        return self == object
    }

}
