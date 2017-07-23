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

final class EmojiAutocomplete {

    private var cachedResults = [String: [EmojiResult]]()

    // MARK: Public API

    func search(_ word: String) -> [EmojiResult] {
        if let cached = cachedResults[word] {
            return cached
        }

        var results = [EmojiResult]()

        for (k, v) in GithubEmojiMap {
            if k.hasPrefix(":" + word) {
                results.append(EmojiResult(emoji: v, term: k))
            }
        }

        cachedResults[word] = results

        return results
    }

}
