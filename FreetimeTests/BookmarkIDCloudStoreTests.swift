//
//  BookmarkIDCloudStoreTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/24/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class FakeBookmarkCloudStoreListener: BookmarkIDCloudStoreListener {
    var updateCount = 0
    func didUpdateBookmarks(in store: BookmarkIDCloudStore) {
        updateCount += 1
    }
}

class BookmarkIDCloudStoreTests: XCTestCase {

    override func setUp() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }

    func test_whenAdd_thatListenerNotified() {
        let listeners = [
            FakeBookmarkCloudStoreListener(),
            FakeBookmarkCloudStoreListener()
        ]
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)
        listeners.forEach { store.add(listener: $0) }

        store.add(graphQLID: "bar")
        XCTAssertTrue(store.contains(graphQLID: "bar"))
        XCTAssertFalse(store.contains(graphQLID: "baz"))
        XCTAssertEqual(store.ids, ["bar"])
        XCTAssertEqual(listeners[0].updateCount, 1)
        XCTAssertEqual(listeners[1].updateCount, 1)

        store.add(graphQLID: "bar")
        XCTAssertEqual(store.ids, ["bar"])
        XCTAssertEqual(listeners[0].updateCount, 1)
        XCTAssertEqual(listeners[1].updateCount, 1)

        store.add(graphQLID: "baz")
        XCTAssertTrue(store.contains(graphQLID: "bar"))
        XCTAssertTrue(store.contains(graphQLID: "baz"))
        XCTAssertEqual(store.ids, ["bar", "baz"])
        XCTAssertEqual(listeners[0].updateCount, 2)
        XCTAssertEqual(listeners[1].updateCount, 2)

        store.remove(graphQLID: "bar")
        XCTAssertFalse(store.contains(graphQLID: "bar"))
        XCTAssertTrue(store.contains(graphQLID: "baz"))
        XCTAssertEqual(store.ids, ["baz"])
        XCTAssertEqual(listeners[0].updateCount, 3)
        XCTAssertEqual(listeners[1].updateCount, 3)

        store.remove(graphQLID: "bar")
        XCTAssertFalse(store.contains(graphQLID: "bar"))
        XCTAssertTrue(store.contains(graphQLID: "baz"))
        XCTAssertEqual(store.ids, ["baz"])
        XCTAssertEqual(listeners[0].updateCount, 3)
        XCTAssertEqual(listeners[1].updateCount, 3)

        store.iCloudDidUpdate()
        XCTAssertEqual(listeners[0].updateCount, 4)
        XCTAssertEqual(listeners[1].updateCount, 4)
    }

    func test_whenAddArray_thatListenerNotified() {
        let listeners = [
            FakeBookmarkCloudStoreListener(),
            FakeBookmarkCloudStoreListener()
        ]
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)
        listeners.forEach { store.add(listener: $0) }

        store.add(graphQLIDs: ["bar"])
        XCTAssertTrue(store.contains(graphQLID: "bar"))
        XCTAssertFalse(store.contains(graphQLID: "baz"))
        XCTAssertEqual(store.ids, ["bar"])
        XCTAssertEqual(listeners[0].updateCount, 1)
        XCTAssertEqual(listeners[1].updateCount, 1)

        store.add(graphQLIDs: ["bar", "baz"])
        XCTAssertTrue(store.contains(graphQLID: "bar"))
        XCTAssertTrue(store.contains(graphQLID: "baz"))
        XCTAssertEqual(store.ids, ["bar", "baz"])
        XCTAssertEqual(listeners[0].updateCount, 2)
        XCTAssertEqual(listeners[1].updateCount, 2)
    }

    func test_onRemove() {
        let store = BookmarkIDCloudStore(username: "foo", iCloudStore: UserDefaults.standard)

        store.add(graphQLID: "bar")
        XCTAssertEqual(store.ids, ["bar"])

        store.remove(graphQLID: "baz")
        XCTAssertEqual(store.ids, ["bar"])

        store.remove(graphQLID: "bar")
        XCTAssertEqual(store.ids, [])
    }

}
