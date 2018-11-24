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

    private let oldBookmarks: [Bookmark]
    private let client: BookmarkCloudMigratorClient

    enum State {
        case inProgress
        case success
        case error
    }

    private(set) var state: State = .inProgress
    private let needsMigrationKey: String

    init(username: String, oldBookmarks: [Bookmark], client: BookmarkCloudMigratorClient) {
        self.oldBookmarks = oldBookmarks
        self.client = client
        self.needsMigrationKey = "com.freetime.bookmark-cloud-migrator.has-migrated.\(username)"
    }

    var needsMigration: Bool {
        get {
            // dont offer migration if no old bookmarks
            return !oldBookmarks.isEmpty
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

        let params: [BookmarkCloudMigratorClientBookmarks] = oldBookmarks.compactMap {
            switch $0.type {
            case .commit, .release, .securityVulnerability: return nil
            case .issue, .pullRequest:
                return .issueOrPullRequest(owner: $0.owner, name: $0.name, number: $0.number)
            case .repo:
                return .repo(owner: $0.owner, name: $0.name)
            }
        }
        guard !params.isEmpty else {
            state = .success
            completion(.noMigration)
            return
        }

        client.fetch(bookmarks: params) { [weak self] result in
            switch result {
            case .success, .noMigration:
                self?.needsMigration = false
                self?.state = .success
            case .error:
                self?.state = .error
            }
            completion(result)
        }
    }

}
