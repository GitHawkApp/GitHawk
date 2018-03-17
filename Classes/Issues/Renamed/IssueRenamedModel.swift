//
//  IssueRenamedEvent.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import StyledText

final class IssueRenamedModel: ListDiffable {

    let id: String
    let actor: String
    let date: Date
    let titleChangeString: StyledTextRenderer

    init(
        id: String,
        actor: String,
        date: Date,
        titleChangeString: StyledTextRenderer
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
