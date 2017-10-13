//
//  IssueCommitModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommitModel: ListDiffable {

    let id: String
    let login: String
    let avatarURL: URL
    let message: String
    let hash: String

    init(id: String, login: String, avatarURL: URL, message: String, hash: String) {
        self.id = id
        self.login = login
        self.avatarURL = avatarURL
        self.message = message
        self.hash = hash
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
