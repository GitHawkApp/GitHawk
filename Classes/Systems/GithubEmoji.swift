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
            let emoji = GithubEmojis.first(where: { $0.regexList.range(of: substr) != nil })
            else { continue }
        replacedString = replacedString.replacingCharacters(in: range, with: emoji.emoji)
    }
    return replacedString
}

private let GithubEmojiRegex: NSRegularExpression = {
    let pattern = "(" + GithubEmojis.map({ $0.regexList }).joined(separator: "|") + ")"
    return try! NSRegularExpression(pattern: pattern, options: [])
}()

struct GitHubEmoji {
    let emoji: String
    let names: [String]
    var regexList: String {
        return names.map({ ":\($0):" }).joined(separator: "|")
    }
    
    init?(dict: [String: Any]) {
        guard let emoji = dict["emoji"] as? String,
              let aliases = dict["aliases"] as? [String],
              let tags = dict["tags"] as? [String]
              else { return nil }
        
        self.emoji = emoji
        self.names = aliases + tags
    }
    
}

var GithubEmojis = [GitHubEmoji]()

func loadGitHubEmojis() {
    guard let url = Bundle.main.url(forResource: "emoji", withExtension: "json"),
          let data = try? Data(contentsOf: url),
          let json = try? JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0)),
          let dict = json as? [[String: Any]] else { return }
    
    GithubEmojis = dict.flatMap { GitHubEmoji(dict: $0) }
}
