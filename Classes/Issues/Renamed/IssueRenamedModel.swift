//
//  IssueRenamedEvent.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueRenamedModel: ListDiffable {

    let id: String
    let actor: String
    let date: Date
    let titleChangeString: NSAttributedStringSizing

    init(
        id: String,
        actor: String,
        date: Date,
        titleChangeString: NSAttributedStringSizing
        ) {
        self.id = id
        self.actor = actor
        self.date = date
        self.titleChangeString = titleChangeString
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return id as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
