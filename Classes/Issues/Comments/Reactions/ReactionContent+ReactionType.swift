//
//  ReactionContent+ReactionType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ReactionContent {
    var type: ReactionType {
        switch self {
        case .confused: return .confused
        case .heart: return .heart
        case .hooray: return .hooray
        case .laugh: return .laugh
        case .thumbsUp: return .thumbsUp
        case .thumbsDown: return .thumbsDown
        }
    }
}
