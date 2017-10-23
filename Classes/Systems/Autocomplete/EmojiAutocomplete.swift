//
//  EmojiAutocomplete.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class EmojiAutocomplete: AutocompleteType {

    private struct Result {
        let emoji: String
        let term: String
    }

    private var cachedResults = [String: [Result]]()
    private var results = [Result]()

    // MARK: AutocompleteType

    var prefix: String {
        return ":"
    }

    var resultsCount: Int {
        return results.count
    }

    func configure(cell: AutocompleteCell, index: Int) {
        let result = results[index]
        cell.configure(state: .emoji(emoji: result.emoji, term: result.term))
    }

    func search(word: String, completion: @escaping (Bool) -> Void) {
        if let cached = cachedResults[word] {
            self.results = cached
            completion(cached.count > 0)
        }

        let lowerword = word.lowercased()
        let results: [Result] = GithubEmojis.search.reduce([Result]()) {
            if $1.key.lowercased().hasPrefix(lowerword) {
                return $0 + $1.value.map { Result(emoji: $0.emoji, term: $0.name) }
            }
            return $0
        }

        self.results = results
        cachedResults[word] = results

        completion(results.count > 0)
    }

    func accept(index: Int) -> String? {
        return results[index].emoji
    }

}
