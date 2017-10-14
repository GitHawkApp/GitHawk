//
//  NotificationViewModel+Filter.swift
//  Freetime
//
//  Created by Weyert de Boer on 08/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

func filterNotifications(_ items: [NotificationViewModel], _ query: String) -> [ListDiffable] {
    guard !query.isEmpty else { return items as [ListDiffable] }

    let searchText = query.lowercased()

    let filteredItems: [NotificationViewModel] = items.filter { item in

        if query.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            switch item.identifier {
            case .number(let id):
                let ticketId = String(id)
                return ticketId.contains(searchText)
            default: break
            }
        }
        
        let title = item.title.attributedText.string.lowercased()
        if title.contains(searchText) { return true }

        let owner = item.owner.lowercased()
        if owner.contains(searchText) { return true }

        let repo = item.repo.lowercased()
        if repo.contains(searchText) { return true }
        return false
    }

    return filteredItems
}
