//
//  GithubEmoji.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct GitHubEmoji {
    let emoji: String
    let name: String
    let aliases: [String]
    let tags: [String]

    init?(dict: [String: Any]) {
        guard let emoji = dict["emoji"] as? String,
            let aliases = dict["aliases"] as? [String],
            let name = aliases.first,
            let tags = dict["tags"] as? [String]
            else { return nil }

        self.emoji = emoji
        self.name = name
        self.aliases = aliases
        self.tags = tags
    }

}

// alias = ":smiley:" (surrounded w/ colons), search = words
typealias EmojiStore = (alias: [String: GitHubEmoji], search: [String: [GitHubEmoji]])

let GithubEmojis: EmojiStore = {
    guard let url = Bundle.main.url(forResource: "emoji", withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let json = try? JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)),
        let dict = json as? [[String: Any]] else { return ([:], [:]) }

    let emojis = dict.compactMap { GitHubEmoji(dict: $0) }

    var aliasMap = [String: GitHubEmoji]()
    var searchMap = [String: [GitHubEmoji]]()

    for emoji in emojis {
        for alias in emoji.aliases {
            aliasMap[":" + alias + ":"] = emoji

            // aliases have to be unique
            searchMap[alias] = [emoji]
        }

        // collect all emoji tags
        for tag in emoji.tags {
            var arr = searchMap[tag] ?? []
            arr.append(emoji)
            searchMap[tag] = arr
        }
    }

    return (aliasMap, searchMap)
}()
