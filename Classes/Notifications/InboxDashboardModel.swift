//
//  InboxDashboardModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 12/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import StyledTextKit
import IGListKit
import FlatCache

struct InboxDashboardModel: ListSwiftDiffable, Cachable {

    let owner: String
    let name: String
    let number: Int
    let date: Date
    let text: StyledTextRenderer
    let isPullRequest: Bool
    let state: NotificationViewModel.State

    // MARK: Identifiable

    var id: String {
        return identifier
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return "\(owner).\(name).\(number)"
    }

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? InboxDashboardModel else { return false }
        return owner == value.owner
            && name == value.name
            && number == value.number
            && date == value.date
            && isPullRequest == value.isPullRequest
            && text.string == value.text.string
            && state == value.state
    }

}
