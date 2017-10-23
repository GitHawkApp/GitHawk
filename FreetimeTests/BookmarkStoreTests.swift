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

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        BookmarksStore.shared.clear()
    }

    func test_addBookMark() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        BookmarksStore.shared.add(bookmark: b1)

        XCTAssert(BookmarksStore.shared.bookmarks.count == 1)
        XCTAssert(BookmarksStore.shared.bookmarks.first == b1)
    }

    func test_duplicateBookmarks() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")
        let b2 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        BookmarksStore.shared.add(bookmark: b1)
        BookmarksStore.shared.add(bookmark: b2)

        XCTAssert(BookmarksStore.shared.bookmarks.count == 1)
    }

    func test_clearBookmarks() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        BookmarksStore.shared.add(bookmark: b1)
        BookmarksStore.shared.clear()

        XCTAssert(BookmarksStore.shared.bookmarks.count == 0)
    }

    func test_removeBookmark() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        BookmarksStore.shared.add(bookmark: b1)
        BookmarksStore.shared.remove(bookmark: b1)

        XCTAssert(BookmarksStore.shared.bookmarks.count == 0)
    }
    
    func test_containsBookmark() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")
        
        BookmarksStore.shared.add(bookmark: b1)
        
        XCTAssert(BookmarksStore.shared.contains(bookmark: b1))
    }
}
