//
//  IssueCommentDetailsViewModel.swift
//  Freetime
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

    init(
        date: Date,
        login: String,
        avatarURL: URL
        ) {
        self.date = date
        self.login = login
        self.avatarURL = avatarURL
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
