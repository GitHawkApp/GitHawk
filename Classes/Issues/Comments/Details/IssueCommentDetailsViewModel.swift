//
//  IssueCommentDetailsViewModel.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/19/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueCommentDetailsViewModel: ListDiffable {

    let date: Date
    let login: String
    let avatarURL: URL
    let didAuthor: Bool
    let editedBy: String?
    let editedAt: Date?

    init(
        date: Date,
        login: String,
        avatarURL: URL,
        didAuthor: Bool,
        editedBy: String?,
        editedAt: Date?
        ) {
        self.date = date
        self.login = login
        self.avatarURL = avatarURL
        self.didAuthor = didAuthor
        self.editedBy = editedBy
        self.editedAt = editedAt
    }

    func diffIdentifier() -> NSObjectProtocol {
        return login as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        if self === object { return true }
        guard let object = object as? IssueCommentDetailsViewModel else { return false }
        return date == object.date
            && avatarURL == object.avatarURL
    }

}
