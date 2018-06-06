//
//  Bookmark.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Bookmark: Codable, Equatable {
    let type: NotificationType
    let name: String
    let owner: String
    let number: Int
    let title: String
    let hasIssueEnabled: Bool
    let defaultBranch: String

    init(type: NotificationType,
         name: String,
         owner: String,
         number: Int = 0,
         title: String = "",
         hasIssueEnabled: Bool = false,
         defaultBranch: String = "master"
        ) {
        self.type = type
        self.name = name
        self.owner = owner
        self.number = number
        self.title = title
        self.hasIssueEnabled = hasIssueEnabled
        self.defaultBranch = defaultBranch
    }
}

extension Bookmark: Filterable {
    func match(query: String) -> Bool {
        let lowerQuery = query.lowercased()

        return type.rawValue.contains(lowerQuery) ||
            String(number).contains(lowerQuery) ||
            title.lowercased().contains(lowerQuery) ||
            owner.lowercased().contains(lowerQuery) ||
            name.lowercased().contains(lowerQuery)
    }
}
