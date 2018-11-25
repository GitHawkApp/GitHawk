//
//  BookmarkViewControllerTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/24/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
import IGListKit
@testable import Freetime

private class FakeBookmarkViewControllerClient: BookmarkViewControllerClient,
BookmarkCloudMigratorClient {

    let migratorResult: BookmarkCloudMigratorClientResult
    let clientResult: Result<[ListSwiftDiffable]>
    let infiniteMigration: Bool

    var migratorFetches = 0
    var clientFetches = 0

    init(
        migratorResult: BookmarkCloudMigratorClientResult,
        clientResult: Result<[ListSwiftDiffable]>,
        infiniteMigration: Bool = false
        ) {
        self.migratorResult = migratorResult
        self.clientResult = clientResult
        self.infiniteMigration = infiniteMigration
    }

    func fetch(
        bookmarks: [BookmarkCloudMigratorClientBookmarks],
        completion: @escaping (BookmarkCloudMigratorClientResult) -> Void
        ) {
        migratorFetches += 1
        if infiniteMigration {
            DispatchQueue.main.asyncAfter(deadline: .now() + 60) {
                completion(self.migratorResult)
            }
        } else {
            completion(migratorResult)
        }
    }

    func fetch(graphQLIDs: [String], completion: @escaping (Result<[ListSwiftDiffable]>) -> Void) {
        clientFetches += 1
        completion(clientResult)
    }

}

class BookmarkViewControllerTests: XCTestCase {

    override func setUp() {
        // clearing cloud store
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }

    func test_whenNoMigration_withNoData_thatEmptyViewDisplayed() {
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)
        let client = FakeBookmarkViewControllerClient(
            migratorResult: .noMigration,
            clientResult: .success([])
        )
        let utils = ViewControllerTestUtil(viewController: BookmarkViewController2(
            client: client,
            cloudStore: store,
            oldBookmarks: []
        ))

        let expectation = XCTestExpectation(description: #function)
        DispatchQueue.main.async {
            XCTAssertNotNil(utils.view(with: "initial-empty-view"))
            XCTAssertNotNil(utils.view(with: "feed-collection-view"))
            XCTAssertNil(utils.view(with: "feed-loading-view"))
            XCTAssertNil(utils.view(with: "bookmark-migration-cell"))
            XCTAssertNil(utils.view(with: "base-empty-view"))
            XCTAssertEqual(client.migratorFetches, 0)
            XCTAssertEqual(client.clientFetches, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }

    func test_whenEmptyMigrationResults_withNoData_thatEmptyViewDisplayed() {
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)
        let client = FakeBookmarkViewControllerClient(
            migratorResult: .success([]),
            clientResult: .success([])
        )
        let utils = ViewControllerTestUtil(viewController: BookmarkViewController2(
            client: client,
            cloudStore: store,
            oldBookmarks: []
        ))

        let expectation = XCTestExpectation(description: #function)
        DispatchQueue.main.async {
            XCTAssertNotNil(utils.view(with: "initial-empty-view"))
            XCTAssertNotNil(utils.view(with: "feed-collection-view"))
            XCTAssertNil(utils.view(with: "feed-loading-view"))
            XCTAssertNil(utils.view(with: "bookmark-migration-cell"))
            XCTAssertNil(utils.view(with: "base-empty-view"))
            XCTAssertEqual(client.migratorFetches, 0)
            XCTAssertEqual(client.clientFetches, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }

    func test_whenMigrationError_thatMigrationButtonDisplayed() {
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)
        let client = FakeBookmarkViewControllerClient(
            migratorResult: .error(nil),
            clientResult: .success([])
        )
        let utils = ViewControllerTestUtil(viewController: BookmarkViewController2(
            client: client,
            cloudStore: store,
            oldBookmarks: [Bookmark(type: .repo, name: "foo", owner: "bar")]
        ))

        let expectation = XCTestExpectation(description: #function)
        DispatchQueue.main.async {
            XCTAssertNil(utils.view(with: "initial-empty-view"))
            XCTAssertNotNil(utils.view(with: "feed-collection-view"))
            XCTAssertNil(utils.view(with: "feed-loading-view"))
            XCTAssertNotNil(utils.view(with: "bookmark-migration-cell"))
            XCTAssertNil(utils.view(with: "base-empty-view"))
            XCTAssertEqual(client.migratorFetches, 1)
            XCTAssertEqual(client.clientFetches, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }

    func test_whenMigrationInProgress_thatLoadingViewDisplayed() {
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)
        let client = FakeBookmarkViewControllerClient(
            migratorResult: .success([]),
            clientResult: .success([]),
            infiniteMigration: true
        )
        let utils = ViewControllerTestUtil(viewController: BookmarkViewController2(
            client: client,
            cloudStore: store,
            oldBookmarks: [Bookmark(type: .repo, name: "foo", owner: "bar")]
        ))

        let expectation = XCTestExpectation(description: #function)
        DispatchQueue.main.async {
            XCTAssertNil(utils.view(with: "initial-empty-view"))
            XCTAssertNotNil(utils.view(with: "feed-collection-view"))
            XCTAssertNotNil(utils.view(with: "feed-loading-view"))
            XCTAssertNil(utils.view(with: "bookmark-migration-cell"))
            XCTAssertNil(utils.view(with: "base-empty-view"))
            XCTAssertEqual(client.migratorFetches, 1)
            XCTAssertEqual(client.clientFetches, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }

    func test_whenFetchError_thatEmptyViewDisplayed() {
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)
        let client = FakeBookmarkViewControllerClient(
            migratorResult: .success([]),
            clientResult: .error(nil)
        )
        let utils = ViewControllerTestUtil(viewController: BookmarkViewController2(
            client: client,
            cloudStore: store,
            oldBookmarks: []
        ))

        let expectation = XCTestExpectation(description: #function)
        DispatchQueue.main.async {
            XCTAssertNil(utils.view(with: "initial-empty-view"))
            XCTAssertNotNil(utils.view(with: "feed-collection-view"))
            XCTAssertNil(utils.view(with: "feed-loading-view"))
            XCTAssertNil(utils.view(with: "bookmark-migration-cell"))
            XCTAssertNotNil(utils.view(with: "base-empty-view"))
            XCTAssertEqual(client.migratorFetches, 0)
            XCTAssertEqual(client.clientFetches, 1)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 30)
    }

}
