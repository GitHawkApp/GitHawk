//
//  Bookmark.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct Bookmark: Codable {
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

extension Bookmark: Equatable {
    static func ==(lhs: Bookmark, rhs: Bookmark) -> Bool {
        return lhs.type == rhs.type &&
            lhs.name == rhs.name &&
            lhs.owner == rhs.owner &&
            lhs.number == rhs.number &&
            lhs.title == rhs.title &&
            lhs.hasIssueEnabled == rhs.hasIssueEnabled &&
            lhs.defaultBranch == rhs.defaultBranch
    }
}

extension Bookmark: Filterable {
    func match(query: String) -> Bool {
        let lowerQuery = query.lowercased()

        if type.rawValue.contains(lowerQuery) { return true }
        if String(number).contains(lowerQuery) { return true }
        if title.lowercased().contains(lowerQuery) { return true }
        if owner.lowercased().contains(lowerQuery) { return true }
        if name.lowercased().contains(lowerQuery) { return true }

        return false
    }
}
