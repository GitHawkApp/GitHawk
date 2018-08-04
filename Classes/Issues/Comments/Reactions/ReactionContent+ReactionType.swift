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
  
   static var defaultReaction: ReactionContent {
    return UserDefaults.getDefaultReaction
   }
}
extension String {
  var reaction: ReactionContent {
    switch self {
    case "😕": return .confused
    case "❤️": return .heart
    case "🎉": return .hooray
    case "😄": return .laugh
    case "👍": return .thumbsUp
    case "👎": return .thumbsDown
    default:   return .__unknown(self)
    }
  }
}
