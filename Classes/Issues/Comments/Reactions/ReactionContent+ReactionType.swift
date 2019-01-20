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
        case .rocket: return "🚀"
        case .eyes: return "👀"
        }
    }

    static var reactionsEnabled: Bool {
        return UserDefaults.standard.defaultReaction != nil
    }

    static var defaultReaction: ReactionContent? {
        return UserDefaults.standard.defaultReaction
    }
}
extension String {
    var reaction: ReactionContent? {
        switch self {
        case "😕": return .confused
        case "❤️": return .heart
        case "🎉": return .hooray
        case "😄": return .laugh
        case "👍": return .thumbsUp
        case "👎": return .thumbsDown
        case "🚀": return .rocket
        case "👀": return .eyes
        default:   return nil
        }
    }
}
