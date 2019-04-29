//
//  BookmarkCloudMigratorTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/24/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

struct FakeBookmarkClient: BookmarkCloudMigratorClient {
    let result: BookmarkCloudMigratorClientResult
    func fetch(
        bookmarks: [BookmarkCloudMigratorClientBookmarks],
        completion: @escaping (BookmarkCloudMigratorClientResult) -> Void
        ) {
        completion(result)
    }
}

class BookmarkCloudMigratorTests: XCTestCase {

    override func setUp() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }

    func test_initWithOldValues() {
        let migrator = BookmarkCloudMigrator(
            username: "test",
            oldBookmarks: [
                Bookmark(type: .repo, name: "foo", owner: "bar")
            ],
            client: FakeBookmarkClient(result: .success([]))
        )
        XCTAssertTrue(migrator.needsMigration)
    }

    func test_initWithUnsupportedValues() {
        let migrator = BookmarkCloudMigrator(
            username: "test",
            oldBookmarks: [
                Bookmark(type: .securityVulnerability, name: "foo", owner: "bar")
            ],
            client: FakeBookmarkClient(result: .success([]))
        )
        XCTAssertFalse(migrator.needsMigration)
    }

    func test_initWithEmptyOldValues() {
        let migrator = BookmarkCloudMigrator(
            username: "test",
            oldBookmarks: [],
            client: FakeBookmarkClient(result: .success([]))
        )
        XCTAssertFalse(migrator.needsMigration)
    }

    func test_afterSuccess_doesntNeedMigration() {
        let migrator = BookmarkCloudMigrator(
            username: "test",
            oldBookmarks: [
                Bookmark(type: .repo, name: "foo", owner: "bar")
            ],
            client: FakeBookmarkClient(result: .success([]))
        )
        XCTAssertEqual(migrator.state, .inProgress)
        migrator.sync { _ in }
        XCTAssertFalse(migrator.needsMigration)
        XCTAssertEqual(migrator.state, .success)
    }

    func test_afterError_needMigration() {
        let migrator = BookmarkCloudMigrator(
            username: "test",
            oldBookmarks: [
                Bookmark(type: .repo, name: "foo", owner: "bar")
            ],
            client: FakeBookmarkClient(result: .error(nil))
        )
        XCTAssertEqual(migrator.state, .inProgress)
        migrator.sync { _ in }
        XCTAssertTrue(migrator.needsMigration)
        XCTAssertEqual(migrator.state, .error)
    }

}
