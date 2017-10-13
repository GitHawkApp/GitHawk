//
//  IssueStatus+ButtonState.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 7/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension IssueStatus {
    var buttonState: UIButton.State {
        switch self {
        case .closed: return .closed
        case .open: return .open
        case .merged: return .merged
        }
    }
}
