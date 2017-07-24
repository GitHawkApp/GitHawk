//
//  UserAutocomplete.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class UserAutocomplete: AutocompleteType {

    struct User {
        let avatarURL: URL
        let login: String
    }

    private var cachedResults = [String: [User]]()
    private var results = [User]()
    private let mentionableUsers: [User]

    init(mentionableUsers: [User]) {
        self.mentionableUsers = mentionableUsers
    }

    // MARK: AutocompleteType

    var prefix: String {
        return "@"
    }

    var resultsCount: Int {
        return results.count
    }

    func configure(cell: AutocompleteCell, index: Int) {
        let result = results[index]
        cell.configure(state: .user(avatarURL: result.avatarURL, login: result.login))
    }

    func search(word: String, completion: @escaping (Bool) -> ()) {
        if let cached = cachedResults[word] {
            self.results = cached
            completion(cached.count > 0)
        }

        var results = [User]()

        for u in mentionableUsers {
            if u.login.hasPrefix(word) {
                results.append(u)
            }
        }

        self.results = results
        cachedResults[word] = results

        completion(results.count > 0)
    }

    func accept(index: Int) -> String? {
        return prefix + results[index].login
    }

}
