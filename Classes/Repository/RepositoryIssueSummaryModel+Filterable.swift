//
//  RepositoryIssueSummaryModel+Filterable.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

extension RepositoryIssueSummaryModel: Filterable {

    func match(query: String) -> Bool {
        if query.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
            let ticketNumber = String(number)
            return ticketNumber.contains(query)
        }

        let lowerQuery = query.lowercased()

        if title.attributedText.string.lowercased().contains(lowerQuery) { return true }
        if author.lowercased().contains(lowerQuery) { return true }

        return false
    }

}
