//
//  LRUCacheTests.swift
//  StyledTextTests
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import StyledText

struct TestValue: LRUCachable {
    let size: Int
    let value: String
    var cachedSize: Int {
        return size
    }
}

class LRUCacheTests: XCTestCase {

    func test_whenInitializingCache_thatMaxSizeSet() {
        let cache = LRUCache<String, TestValue>(maxSize: 10)
        XCTAssertEqual(cache.maxSize, 10)
    }

    func test_whenGettingFromEmptyCache_thatNilReturned() {
        let cache = LRUCache<String, TestValue>(maxSize: 10)
        XCTAssertNil(cache.get("foo"))
    }
    
    func test_whenSetting_gettingReturnsSameObject() {
        let cache = LRUCache<String, TestValue>(maxSize: 10)
        cache.set("foo", value: TestValue(size: 1, value: "cat"))
        XCTAssertEqual(cache.get("foo")?.value, "cat")
    }

    func test_whenSettingMultipleTimes_thatHeadBumped() {
        let cache = LRUCache<String, TestValue>(maxSize: 10)

        cache.set("foo", value: TestValue(size: 1, value: "cat"))
        cache.set("bar", value: TestValue(size: 1, value: "dog"))
        cache.set("baz", value: TestValue(size: 1, value: "rat"))
        cache.set("bang", value: TestValue(size: 1, value: "bug"))

        XCTAssertEqual(cache.map.count, 4)
        XCTAssertEqual(cache.head?.value.value, "bug")
        XCTAssertEqual(cache.head?.key, "bang")

        XCTAssertEqual(cache.get("foo")?.value, "cat")

        XCTAssertEqual(cache.map.count, 4)
        XCTAssertEqual(cache.head?.value.value, "cat")
        XCTAssertEqual(cache.head?.key, "foo")
    }
    
}
