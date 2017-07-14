//
//  IssueAssigneesModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class IssueAssigneesModel: ListDiffable {

    enum Assignment: String {
        case assigned = "assigned"
        case reviewRequested = "reviewRequested"
    }

    let users: [IssueAssigneeViewModel]
    let type: Assignment

    init(users: [IssueAssigneeViewModel], type: Assignment) {
        self.users = users
        self.type = type
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return type.rawValue as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }

}
