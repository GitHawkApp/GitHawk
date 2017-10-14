//
//  RepositoryIssueSummaryModel+Filter.swift
//  Freetime
//
//  Created by Weyert de Boer on 09/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import IGListKit

/// Filter issues with the given search query string
func filterIssues(_ items: [ListDiffable], _ query: String) -> [ListDiffable] {
    guard !query.isEmpty else {  return items }

    let searchText = query.lowercased()
    let queryResults: SearchQueryParseResults = tokenizeSearchQuery(searchText)

    let filteredItems = items.filter { item -> Bool in
        // If every non RepositoryIssueSummaryModel type will never be filtered as they can be the head models
        guard let summaryModel = item as? RepositoryIssueSummaryModel else { return true }
        let filterResults = queryResults.tokens.flatMap { action, value -> Bool in
            switch action {
            case .user: return summaryModel.author.lowercased().contains(value)
            case .status: return isIssueStatus(status: summaryModel.status, text: value)
            }
        }

        return filterResults.reduce(true) { (next, item) -> Bool in
            return next && item
        }
    }

    if queryResults.leftover.isEmpty {
        return filteredItems
    }

    let relevantItems = filteredItems.filter { item -> Bool in
        // If every non RepositoryIssueSummaryModel type will never be filtered as they can be the head models
        guard let summaryModel = item as? RepositoryIssueSummaryModel else { return true }

        // If the search query is numeric then we shouldn't bother checking anything else
        if searchText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            let ticketNumber = String(summaryModel.number)
            return ticketNumber.contains(queryResults.leftover)
        }

        let title = summaryModel.title.attributedText.string.lowercased()
        if title.contains(queryResults.leftover) { return true }

        let author = summaryModel.author.lowercased()
        if author.contains(queryResults.leftover) { return true }

        return false
    }

    return relevantItems
}
