//
//  NotificationViewModel2.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit
import FlatCache
import StyledTextKit

struct NotificationViewModel2: ListSwiftDiffable, Cachable {

    enum Identifier {
        case number(Int)
        case hash(String)
        case release(String)
    }

    // combining possible issue and PR states
    // https://developer.github.com/v4/enum/issuestate/
    // https://developer.github.com/v4/enum/pullrequeststate/
    enum State: String {
        case pending
        case closed = "CLOSED"
        case merged = "MERGED"
        case open = "OPEN"
    }

    var v3id: String
    var repo: String
    var owner: String
    var title: StyledTextRenderer
    var ident: Identifier
    var state: State
    var date: Date
    var ago: String // only used for diffing to capture "ago" string at model init
    var read: Bool
    var comments: Int
    var watching: Bool
    var type: NotificationType
    var branch: String
    var issuesEnabled: Bool

    // MARK: Identifiable

    var id: String {
        return v3id
    }

    // MARK: ListSwiftDiffable

    var identifier: String {
        return v3id
    }

    // MARK: ListSwiftEquatable

    func isEqual(to value: ListSwiftDiffable) -> Bool {
        guard let value = value as? NotificationViewModel2 else { return false }
        // making assumptions that given the v3id, most things don't change
        return read == value.read
            && comments == value.comments
            && watching == value.watching
            && state == value.state
            && ago == value.ago
            && title.string == value.title.string
    }

}
