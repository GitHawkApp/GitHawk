//
//  UserAutocomplete+GraphQL.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension IssueOrPullRequestQuery.Data.Repository.MentionableUser {

    typealias User = UserAutocomplete.User
    var userAutocompletes: [User] {
        var results = [User]()
        for node in nodes ?? [] {
            guard let node = node, let avatarURL = URL(string: node.avatarUrl) else { continue }
            results.append(User(avatarURL: avatarURL, login: node.login))
        }
        return results
    }

}
