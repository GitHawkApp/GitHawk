//
//  SearchQueryTokenizer.swift
//  Freetime
//
//  Created by Weyert de Boer on 09/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

struct SearchQueryParseResults {
    let tokens: [Token]
    let leftover: String
}

enum TokenAction: String {
    case status = "is"
    case user = "user"
}

typealias Token = (action: TokenAction, value: String)

/// Tokenizes a search query and returns an instance of ParseResult which consists
/// of all the found "search tokens" such as `is:closed` and separately returns
/// the text of the search query which isn't part of any search token
func tokenizeSearchQuery(_ query: String) -> SearchQueryParseResults {
    let chunks = query.components(separatedBy: " ")

    var leftover: String = query
    let tokens: [Token] = chunks.compactMap { chunk -> Token? in
        let chunk = chunk.trimmingCharacters(in: .whitespacesAndNewlines)
        let valueChunks = chunk.components(separatedBy: ":")
        guard !valueChunks.isEmpty else { return nil }

        if valueChunks.count == 2, let action = valueChunks.first, let tokenValue = valueChunks.last {
            guard let tokenAction = TokenAction(rawValue: action.lowercased()) else { return nil }
            leftover = leftover.replacingOccurrences(of: chunk, with: "")
            return Token(tokenAction, tokenValue)
        }

        return nil
    }

    let trimmedLeftover = leftover.trimmingCharacters(in: .whitespacesAndNewlines)
    return SearchQueryParseResults(tokens: tokens, leftover: trimmedLeftover)
}

func isIssueStatus(status: IssueStatus, text: String) -> Bool {
    let text = text.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
    switch status {
    case .open: return text == "open"
    case .closed: return text == "closed"
    case .merged: return text == "merged"
    }
}
