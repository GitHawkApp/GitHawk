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
        cache.set("baz", value: TestValue(size: 3, value: "rat"))
        cache.set("bang", value: TestValue(size: 1, value: "bug"))

        XCTAssertEqual(cache.map.count, 4)
        XCTAssertEqual(cache.size, 6)
        XCTAssertEqual(cache.head?.value.value, "bug")
        XCTAssertEqual(cache.head?.key, "bang")

        XCTAssertEqual(cache.get("foo")?.value, "cat")

        XCTAssertEqual(cache.map.count, 4)
        XCTAssertEqual(cache.head?.value.value, "cat")
        XCTAssertEqual(cache.head?.key, "foo")
    }

    func test_whenExceedingMaxSize_withDefaultCompaction_thatCachePurged() {
        let cache = LRUCache<String, TestValue>(maxSize: 10)

        cache.set("foo", value: TestValue(size: 1, value: "cat"))
        cache.set("bar", value: TestValue(size: 2, value: "dog"))
        cache.set("baz", value: TestValue(size: 3, value: "rat"))
        cache.set("bang", value: TestValue(size: 4, value: "bug"))

        XCTAssertEqual(cache.map.count, 4)
        XCTAssertEqual(cache.size, 10)

        cache.set("bop", value: TestValue(size: 3, value: "pig"))

        XCTAssertEqual(cache.map.count, 3)
        XCTAssertEqual(cache.size, 10)
        XCTAssertEqual(cache.head?.value.value, "pig")
        XCTAssertEqual(cache.head?.key, "bop")
    }

    func test_whenPercentCompactionOOB_thatInitWithDefault() {
        let zeroCompact = LRUCache<String, TestValue>(maxSize: 10, compaction: .percent(0)).compaction
        switch zeroCompact {
        case .percent:
            XCTFail()
        default: break
        }

        let negativeCompact = LRUCache<String, TestValue>(maxSize: 10, compaction: .percent(-1)).compaction
        switch negativeCompact {
        case .percent:
            XCTFail()
        default: break
        }

        let tooBigCompact = LRUCache<String, TestValue>(maxSize: 10, compaction: .percent(1.1)).compaction
        switch tooBigCompact {
        case .percent:
            XCTFail()
        default: break
        }
    }

    func test_whenExceedingMaxSize_with50PercentCompaction_thatCachePurged() {
        let cache = LRUCache<String, TestValue>(maxSize: 10, compaction: .percent(0.5))

        cache.set("foo", value: TestValue(size: 4, value: "cat"))
        cache.set("bar", value: TestValue(size: 3, value: "dog"))
        cache.set("baz", value: TestValue(size: 3, value: "rat"))

        cache.set("bang", value: TestValue(size: 3, value: "bug"))

        XCTAssertEqual(cache.map.count, 1)
        XCTAssertEqual(cache.size, 3)
        XCTAssertEqual(cache.head?.value.value, "bug")
        XCTAssertEqual(cache.head?.key, "bang")
    }

    func test_whenOverwritingExistingKey_thatSizeUpdates() {
        let cache = LRUCache<String, TestValue>(maxSize: 10)

        cache.set("foo", value: TestValue(size: 1, value: "cat"))
        XCTAssertEqual(cache.map.count, 1)
        XCTAssertEqual(cache.size, 1)
        XCTAssertEqual(cache.get("foo")?.value, "cat")

        cache.set("foo", value: TestValue(size: 3, value: "dog"))
        XCTAssertEqual(cache.map.count, 1)
        XCTAssertEqual(cache.size, 3)
        XCTAssertEqual(cache.get("foo")?.value, "dog")
    }

    func test_whenClearingCache_thatValuesReset() {
        let cache = LRUCache<String, TestValue>(maxSize: 10)

        cache.set("foo", value: TestValue(size: 4, value: "cat"))
        cache.set("bar", value: TestValue(size: 3, value: "dog"))
        cache.set("baz", value: TestValue(size: 3, value: "rat"))

        XCTAssertEqual(cache.map.count, 3)
        XCTAssertEqual(cache.size, 10)

        cache.clear()

        XCTAssertEqual(cache.map.count, 0)
        XCTAssertEqual(cache.size, 0)
        XCTAssertNil(cache.head)
    }

    func test_whenConfiguredForMemoryWarning_thatCacheClears() {
        let cache = LRUCache<String, TestValue>(maxSize: 10, clearOnWarning: true)

        cache.set("foo", value: TestValue(size: 4, value: "cat"))
        cache.set("bar", value: TestValue(size: 3, value: "dog"))
        cache.set("baz", value: TestValue(size: 3, value: "rat"))

        XCTAssertEqual(cache.map.count, 3)
        XCTAssertEqual(cache.size, 10)

        NotificationCenter.default.post(Notification(name: Notification.Name.UIApplicationDidReceiveMemoryWarning))

        XCTAssertEqual(cache.map.count, 0)
        XCTAssertEqual(cache.size, 0)
        XCTAssertNil(cache.head)
    }

    func test_whenNotForMemoryWarning_thatCacheUnchanged() {
        let cache = LRUCache<String, TestValue>(maxSize: 10, clearOnWarning: false)

        cache.set("foo", value: TestValue(size: 4, value: "cat"))
        cache.set("bar", value: TestValue(size: 3, value: "dog"))
        cache.set("baz", value: TestValue(size: 3, value: "rat"))

        XCTAssertEqual(cache.map.count, 3)
        XCTAssertEqual(cache.size, 10)

        NotificationCenter.default.post(Notification(name: Notification.Name.UIApplicationDidReceiveMemoryWarning))

        XCTAssertEqual(cache.map.count, 3)
        XCTAssertEqual(cache.size, 10)
    }
    
}
