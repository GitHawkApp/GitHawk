//
//  SearchRecentStoreTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

import XCTest

@testable import Freetime
class SearchRecentStoreTests: XCTestCase {
    var store: SearchRecentStore!

    override func setUp() {
        super.setUp()
        store = SearchRecentStore()
        store.clear() // in case you've used the app in-simulator before running these tests
    }

    override func tearDown() {
        super.tearDown()
        store?.clear()
    }

    func test_add_canReorderObjects() {
        store.add(recent: "samurai jack")
        store.add(recent: "aku")
        store.add(recent: "samurai jack")

        let expected = "samurai jack"
        let actual = store.recents.first

        XCTAssertEqual(expected, actual)
    }

    func test_clear_removesAllObjects() {
        store.add(recent: "cat")
        store.add(recent: "bug")
        store.clear()

        XCTAssertTrue(store.recents.isEmpty)
    }

    func test_removesLast_doesntCrashOnEmpty() {
        XCTAssertTrue(store.recents.isEmpty)
        store.removeLast()
    }

    func test_removesLast_removesLastObject() {
        store.add(recent: "finn")
        store.add(recent: "jake")
        store.removeLast()

        let expectedCount = 1
        let actualCount = store.recents.count

        XCTAssertEqual(expectedCount, actualCount)
    }
}
