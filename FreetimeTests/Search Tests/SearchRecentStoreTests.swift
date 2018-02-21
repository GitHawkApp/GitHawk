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
        store.add(.search("Samurai Jack"))
        store.add(.search("aku"))
        store.add(.search("samurai jack"))

        let expected: SearchQuery = .search("samurai jack")
        let actual = store.values.first

        XCTAssertEqual(expected, actual)
    }

    func test_clear_removesAllObjects() {
        store.add(.search("cat"))
        store.add(.search("bug"))
        store.clear()

        XCTAssertTrue(store.values.isEmpty)
    }

    func test_remove() {
        store.add(.search("finn"))
        store.remove(.search("finn"))

        let expectedCount = 0
        let actualCount = store.values.count

        XCTAssertEqual(expectedCount, actualCount)
    }

    func test_remove_takesNoAction_ifNotPresent() {
        store.add(.search("finn"))
        store.remove(.search("jake"))

        let expectedCount = 1
        let actualCount = store.values.count

        XCTAssertEqual(expectedCount, actualCount)
    }

}
