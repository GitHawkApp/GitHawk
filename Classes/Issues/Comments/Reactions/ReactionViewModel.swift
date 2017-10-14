//
//  ReactionViewModel.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/1/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct ReactionViewModel {

    let content: ReactionContent
    let count: Int
    let viewerDidReact: Bool
    let users: [String]

}

func createReactionDetailText(model: ReactionViewModel) -> String {
    let users = model.users
    switch model.count {
    case 0:
        return ""
    case 1:
        let format = NSLocalizedString("%@", comment: "")
        return .localizedStringWithFormat(format, users[0])
    case 2:
        let format = NSLocalizedString("%@ and %@", comment: "")
        return .localizedStringWithFormat(format, users[0], users[1])
    case 3:
        let format = NSLocalizedString("%@, %@ and %@", comment: "")
        return .localizedStringWithFormat(format, users[0], users[1], users[2])
    default:
        let difference = model.count - users.count
        let format = NSLocalizedString("%@, %@, %@ and %d other(s)", comment: "")
        return .localizedStringWithFormat(format, users[0], users[1], users[2], difference)
    }
}
