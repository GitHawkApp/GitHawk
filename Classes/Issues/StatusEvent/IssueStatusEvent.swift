//
//  IssueStatusEvent.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum IssueStatusEvent: Int {
    case reopened
    case closed
    case merged
    case locked
    case unlocked
}
