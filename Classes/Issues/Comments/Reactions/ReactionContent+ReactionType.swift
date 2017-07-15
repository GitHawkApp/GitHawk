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
        case .thumbsUp: return "👍"
        case .thumbsDown: return "👎"
        }
    }
    
    /// User readable name of the current reaction type
    var name: String {
        switch self {
        case .confused: return "confused"
        case .heart: return "heart"
        case .hooray: return "horray"
        case .laugh: return "laugh"
        case .thumbsUp: return "thumbs up"
        case .thumbsDown: return "thumbs down"
        }
    }
}
