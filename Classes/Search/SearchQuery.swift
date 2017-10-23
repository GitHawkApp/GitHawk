//
//  SearchQuery.swift
//  Freetime
//
//  Created by Hesham Salman on 10/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

enum SearchQuery: Codable, Equatable {
    case search(String), recentlyViewed(RepositoryDetails)

    private enum CodingKeys: String, CodingKey {
        case search
        case recentlyViewed
    }

    enum SearchQueryCodingError: Error {
        case decoding(String)
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try? values.decode(String.self, forKey: .search) {
            self = .search(value)
            return
        }
        if let value = try? values.decode(RepositoryDetails.self, forKey: .recentlyViewed) {
            self = .recentlyViewed(value)
            return
        }
        throw SearchQueryCodingError.decoding("Unable to decode SearchQuery! \(dump(values))")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .search(let text):
            try container.encode(text, forKey: .search)
        case .recentlyViewed(let repo):
            try container.encode(repo, forKey: .recentlyViewed)
        }
    }
}

func == (lhs: SearchQuery, rhs: SearchQuery) -> Bool {
    switch (lhs, rhs) {
    case (let .search(lhsText), let .search(rhsText)):
        return lhsText == rhsText
    case (let .recentlyViewed(lhsRepo), let .recentlyViewed(rhsRepo)):
        return lhsRepo == rhsRepo
    default:
        return false
    }
}
