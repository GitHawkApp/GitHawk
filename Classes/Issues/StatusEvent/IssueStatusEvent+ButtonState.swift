//
//  IssueStatusEvent+ButtonState.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension IssueStatusEvent {
    var buttonState: UIButton.State {
        switch self {
        case .closed: return .closed
        case .reopened: return .open
        case .merged: return .merged
        case .locked: return .locked
        case .unlocked: return .unlocked
        }
    }
}
