//
//  IssueStatus.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/28/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum IssueStatus: Int {
    case closed
    case open
    case merged

    var title: String {
        switch self {
        case .open: return Constants.Strings.open
        case .closed: return Constants.Strings.closed
        case .merged: return Constants.Strings.merged
        }
    }
}
