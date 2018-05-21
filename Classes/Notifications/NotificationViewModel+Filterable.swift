//
//  NotificationViewModel+Filterable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension NotificationViewModel: Filterable {

    func match(query: String) -> Bool {
        // if query is a number and model is issue/PR, match on the number
        switch identifier {
        case .number(let id):
            if query.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
                let ticketId = String(id)
                return ticketId.contains(query)
            }
        default: break
        }

        let lowerQuery = query.lowercased()
        if title.string.allText.lowercased().contains(lowerQuery) { return true }
        if owner.lowercased().contains(lowerQuery) { return true }
        if repo.lowercased().contains(lowerQuery) { return true }

        return false
    }

}
