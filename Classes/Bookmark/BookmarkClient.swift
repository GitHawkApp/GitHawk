//
//  BookmarkClient.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/24/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import GitHubAPI
import FlatCache

enum BookmarkModel {
    case repo
    case issueOrPullRequest
}

final class BookmarkClient {

    private let client: Client
    private let cache: FlatCache

    init(client: Client, cache: FlatCache) {
        self.client = client
        self.cache = cache
    }

    func models(for graphQLIDs: [String]) -> [BookmarkModel] {
        return []
    }

}
