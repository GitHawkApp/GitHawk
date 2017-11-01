//
//  BookmarkStoreTests.swift
//  FreetimeTests
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

final class BookmarkStoreTests: XCTestCase {
    var store: BookmarksStore!
    
    override func setUp() {
        super.setUp()
        store = BookmarksStore("user_token")
        store.clear() // for a clean start
    }

    override func tearDown() {
        super.tearDown()
        store.clear()
    }

    func test_addBookMark() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        store.add(bookmark: b1)

        XCTAssert(store.bookmarks.count == 1)
        XCTAssert(store.bookmarks.first == b1)
    }

    func test_duplicateBookmarks() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")
        let b2 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        store.add(bookmark: b1)
        store.add(bookmark: b2)

        XCTAssert(store.bookmarks.count == 1)
    }

    func test_clearBookmarks() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        store.add(bookmark: b1)
        store.clear()

        XCTAssert(store.bookmarks.isEmpty)
    }

    func test_removeBookmark() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        store.add(bookmark: b1)
        store.remove(bookmark: b1)

        XCTAssert(store.bookmarks.count == 0)
    }
    
    func test_bookmarksFromDifferentUser() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        let store1 = BookmarksStore("user_token1")
        let store2 = BookmarksStore("user_token2")

        store1.add(bookmark: b1)
        store2.add(bookmark: b1)

        XCTAssert(store1.bookmarks.count == 1)
        XCTAssert(store2.bookmarks.count == 1)
        XCTAssert(store1.bookmarkPath != store2.bookmarkPath)
    }

    func test_bookmarksOrder() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")
        let b2 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rnystrom")

        store.add(bookmark: b1)
        store.add(bookmark: b2)

        XCTAssert(store.bookmarks[0] == b2)
        XCTAssert(store.bookmarks[1] == b1)
    }

    func test_bookmarksMixedTypes() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")
        let b2 = BookmarkModel(type: .issue, name: "GitHawk", owner: "rizwankce", number: 10, title: "Issue")
        let b3 = BookmarkModel(type: .pullRequest, name: "GitHawk", owner: "rizwankce", number: 11, title: "Pull request")

        store.add(bookmark: b1)
        store.add(bookmark: b2)
        store.add(bookmark: b3)

        XCTAssert(store.bookmarks[0].type == .pullRequest)
        XCTAssert(store.bookmarks[1].type == .issue)
        XCTAssert(store.bookmarks[2].type == .repo)
    }
}
