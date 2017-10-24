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
        store.add(query: .search("Samurai Jack"))
        store.add(query: .search("aku"))
        store.add(query: .search("samurai jack"))

        let expected: SearchQuery = .search("samurai jack")
        let actual = store.recents.first

        XCTAssertEqual(expected, actual)
    }

    func test_clear_removesAllObjects() {
        store.add(query: .search("cat"))
        store.add(query: .search("bug"))
        store.clear()

        XCTAssertTrue(store.recents.isEmpty)
    }

    func test_remove() {
        store.add(query: .search("finn"))
        store.remove(query: .search("finn"))

        let expectedCount = 0
        let actualCount = store.recents.count

        XCTAssertEqual(expectedCount, actualCount)
    }

    func test_remove_takesNoAction_ifNotPresent() {
        store.add(query: .search("finn"))
        store.remove(query: .search("jake"))

        let expectedCount = 1
        let actualCount = store.recents.count

        XCTAssertEqual(expectedCount, actualCount)
    }

}
