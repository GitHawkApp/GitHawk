//
//  IssueMergeType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/12/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

enum IssueMergeType: Int {
    case merge
    case rebase
    case squash

    var localized: String {
        switch self {
        case .merge: return NSLocalizedString("Merge", comment: "")
        case .rebase: return NSLocalizedString("Rebase", comment: "")
        case .squash: return NSLocalizedString("Squash", comment: "")
        }
    }
}
