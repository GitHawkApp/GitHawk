//
//  Defaults+Reaction.swift
//  Freetime
//
//  Created by Ehud Adler on 7/30/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//
extension UserDefaults {

    private static let defaultKey = "com.whoisryannystrom.freetime.default-reaction"
    private static let disabledValue = "disabled"

    // Stores ReactionContent in string form but
    // accepts and returns in original form
    func setDefault(reaction: ReactionContent) {
        set(reaction.emoji, forKey: UserDefaults.defaultKey)
    }

    func disableReaction() {
        set(UserDefaults.disabledValue, forKey: UserDefaults.defaultKey)
    }

    var defaultReaction: ReactionContent? {
        // if value doesn't exist, first access, default to previous behavior of +1
        guard let value = string(forKey: UserDefaults.defaultKey)
            else { return ReactionContent.thumbsUp }
        if value == UserDefaults.disabledValue {
            return nil
        } else {
            let reaction = value.reaction
            return reaction
        }
    }

}
