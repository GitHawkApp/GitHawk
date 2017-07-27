//
//  UserAutocomplete+GraphQL.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension IssueOrPullRequestQuery.Data.Repository.MentionableUser {

    var autocompleteUsers: [AutocompleteUser] {
        var results = [AutocompleteUser]()
        for node in nodes ?? [] {
            guard let node = node, let avatarURL = URL(string: node.avatarUrl) else { continue }
            results.append(AutocompleteUser(avatarURL: avatarURL, login: node.login))
        }
        return results
    }

}
