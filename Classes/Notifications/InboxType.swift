//
//  InboxType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/16/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

enum InboxType {
    case unread
    case repo(Repository)
    case all

    var showAll: Bool {
        switch self {
        case .all, .repo: return true
        case .unread: return false
        }
    }
}
