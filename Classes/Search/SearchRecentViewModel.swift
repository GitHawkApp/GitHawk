//
//  SearchRecentViewModel.swift
//  Freetime
//
//  Created by Hesham Salman on 10/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import IGListKit

final class SearchRecentViewModel: ListDiffable {

    let query: SearchQuery

    init(query: SearchQuery) {
        self.query = query
    }

    var displayText: String {
        switch query {
        case .search(let text):
            return text
        case .recentlyViewed(let repoDetails):
            return repoDetails.owner + "/" + repoDetails.name
        }
    }

    var icon: UIImage {
        switch query {
        case .search:
            return #imageLiteral(resourceName: "search")
        case .recentlyViewed:
            return #imageLiteral(resourceName: "repo")
        }
    }

    // MARK: ListDiffable

    func diffIdentifier() -> NSObjectProtocol {
        return icon as NSObjectProtocol
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        return true
    }
}

