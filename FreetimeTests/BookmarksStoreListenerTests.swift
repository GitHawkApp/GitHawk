//
//  BookmarksStoreListenerTests.swift
//  FreetimeTests
//
//  Created by Rizwan on 30/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class BookmarksStoreListenerTests: XCTestCase, BookmarksStoreListener {
    var store: BookmarksStore!
    let listenerExpectation = XCTestExpectation(description: "listener_expectation")

    override func setUp() {
        super.setUp()
        store = BookmarksStore("user_token")
        store.clear()
        store.add(listener: self)
    }
    
    override func tearDown() {
        super.tearDown()
        store.clear()
    }
    
    func test_listenerForAddingBookmark() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        store.add(bookmark: b1)

        wait(for: [listenerExpectation], timeout: 1.0)
    }

    func test_listenerForRemovingBookmark() {
        let b1 = BookmarkModel(type: .repo, name: "GitHawk", owner: "rizwankce")

        store.remove(bookmark: b1)

        wait(for: [listenerExpectation], timeout: 1.0)
    }

    func test_listenerForClearingBookmark() {
        store.clear()

        wait(for: [listenerExpectation], timeout: 1.0)
    }

    // MARK: BookmarksStoreListener
    func bookmarksDidUpdate() {
        listenerExpectation.fulfill()
    }
}
