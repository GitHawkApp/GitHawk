//
//  Defaults+Reaction.swift
//  Freetime
//
//  Created by Ehud Adler on 7/30/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//
extension UserDefaults {
  // Stores ReactionContent in string form but
  // accepts and returns in original form
  static func setDefault(reaction: ReactionContent)
  {
    standard.set(reaction.emoji, forKey: "default.reaction")
  }
  
  static var getDefaultReaction: ReactionContent
  {
    guard let reactionAsString = standard.string(forKey: "default.reaction")
      else { return ReactionContent.thumbsUp }
    let reaction = reactionAsString.reaction
    return reaction
  }
  
}
