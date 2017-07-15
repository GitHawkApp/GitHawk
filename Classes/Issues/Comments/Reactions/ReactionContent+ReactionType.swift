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
    var localizedString: String {
        switch self {
        case .confused: return NSLocalizedString("confused", comment: "")
        case .heart: return NSLocalizedString("heart", comment: "")
        case .hooray: return NSLocalizedString("hooray", comment: "")
        case .laugh: return NSLocalizedString("laugh", comment: "")
        case .thumbsUp: return NSLocalizedString("thumbs up", comment: "")
        case .thumbsDown: return NSLocalizedString("thumbs down", comment: "")
        }
    }
}
