//
//  IssueAssigneeViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueAssigneeViewModel: ListDiffable {
    let login: String
    let avatarURL: URL

    init(login: String, avatarURL: URL) {
        self.login = login
        self.avatarURL = avatarURL
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return avatarURL as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
