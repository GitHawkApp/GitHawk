//
//  GithubEmoji.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/24/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

func replaceGithubEmojiRegex(string: String) -> String {
    let matches = GithubEmojiRegex.matches(in: string, options: [], range: string.nsrange)
    var replacedString = string
    for match in matches.reversed() {
        guard let substr = string.substring(with: match.range),
            let range = string.range(from: match.range),
            let emoji = GithubEmojis.alias[substr]
            else { continue }
        replacedString = replacedString.replacingCharacters(in: range, with: emoji.emoji)
    }
    return replacedString
}

private let GithubEmojiRegex: NSRegularExpression = {
    let pattern = "(" + GithubEmojis.alias.map({ ":" + $0.key + ":" }).joined(separator: "|") + ")"
    return try! NSRegularExpression(pattern: pattern, options: [])
}()

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

typealias EmojiStore = (alias: [String: GitHubEmoji], search: [String: [GitHubEmoji]])
let GithubEmojis: EmojiStore = {
    guard let url = Bundle.main.url(forResource: "emoji", withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let json = try? JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)),
        let dict = json as? [[String: Any]] else { return ([:], [:]) }

    let emojis = dict.flatMap { GitHubEmoji(dict: $0) }

    var aliasMap = [String: GitHubEmoji]()
    var searchMap = [String: [GitHubEmoji]]()

    for emoji in emojis {
        for alias in emoji.aliases {
            aliasMap[alias] = emoji

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
