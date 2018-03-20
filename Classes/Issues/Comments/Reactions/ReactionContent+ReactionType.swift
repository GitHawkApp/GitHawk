//
//  ReactionContent+ReactionType.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/2/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension ReactionContent {
    var emoji: String {
        switch self {
        case .confused: return "😕"
        case .heart: return "❤️"
        case .hooray: return "🎉"
        case .laugh: return "😄"
        case .thumbsUp, .__unknown: return "👍"
        case .thumbsDown: return "👎"
        }
    }
}
