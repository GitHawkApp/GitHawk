//
//  BookmarkCloudMigrator.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

enum BookmarkCloudMigratorClientResult {
    case noMigration
    case success([String])
    // when oauth restrictions fail some migrations
    case partial(success: [String], errors: Int)
    case error(Error?)
}

enum BookmarkCloudMigratorClientBookmarks {
    case repo(owner: String, name: String)
    case issueOrPullRequest(owner: String, name: String, number: Int)
}

protocol BookmarkCloudMigratorClient {
    func fetch(
        bookmarks: [BookmarkCloudMigratorClientBookmarks],
        completion: @escaping (BookmarkCloudMigratorClientResult) -> Void
    )
}

final class BookmarkCloudMigrator {

    private let bookmarks: [BookmarkCloudMigratorClientBookmarks]
    private let client: BookmarkCloudMigratorClient

    enum State: Int {
        case inProgress
        case success
        case error
    }

    private(set) var state: State = .inProgress
    private let needsMigrationKey: String

    init(username: String, oldBookmarks: [Bookmark], client: BookmarkCloudMigratorClient) {
        self.bookmarks = oldBookmarks.compactMap {
            switch $0.type {
            case .commit, .release, .securityVulnerability: return nil
            case .issue, .pullRequest:
                return .issueOrPullRequest(owner: $0.owner, name: $0.name, number: $0.number)
            case .repo:
                return .repo(owner: $0.owner, name: $0.name)
            }
        }
        self.client = client
        self.needsMigrationKey = "com.freetime.bookmark-cloud-migrator.has-migrated.\(username)"
    }

    var needsMigration: Bool {
        get {
            return state != .success
                // dont offer migration if no old bookmarks
                && !bookmarks.isEmpty
                // or this device has already performed a sync
                && !UserDefaults.standard.bool(forKey: needsMigrationKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: needsMigrationKey)
        }
    }

    func sync(completion: @escaping (BookmarkCloudMigratorClientResult) -> Void) {
        guard needsMigration else {
            state = .success
            completion(.noMigration)
            return
        }

        client.fetch(bookmarks: bookmarks) { [weak self] result in
            switch result {
            case .success, .noMigration, .partial:
                self?.needsMigration = false
                self?.state = .success
            case .error:
                self?.state = .error
            }
            completion(result)
        }
    }

}
