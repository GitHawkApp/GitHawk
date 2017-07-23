//
//  EmojiAutocomplete.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/23/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct EmojiResult {
    let emoji: String
    let term: String
}

final class EmojiAutocomplete: AutocompleteType {

    private var cachedResults = [String: [EmojiResult]]()
    private var results = [EmojiResult]()

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

    func search(word: String, completion: @escaping (Bool) -> ()) {
        if let cached = cachedResults[word] {
            self.results = cached
            completion(cached.count > 0)
        }

        var results = [EmojiResult]()

        for (k, v) in GithubEmojiMap {
            if k.hasPrefix(prefix + word) {
                results.append(EmojiResult(emoji: v, term: k))
            }
        }

        self.results = results
        cachedResults[word] = results
        
        completion(results.count > 0)
    }

    func accept(index: Int) -> String? {
        return results[index].emoji
    }

}
