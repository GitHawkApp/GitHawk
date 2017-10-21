//
//  FlatCacheTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 10/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

struct CacheModel: Cachable {
    let id: String
    let value: String
}

class CacheModelListener: FlatCacheListener {
    var receivedItemQueue = [CacheModel]()
    var receivedListQueue = [[CacheModel]]()

    func flatCacheDidUpdate(cache: FlatCache, update: FlatCache.Update) {
        switch update {
        case .item(let item): receivedItemQueue.append(item as! CacheModel)
        case .list(let list): receivedListQueue.append(list as! [CacheModel])
        }
    }
}

struct OtherCacheModel: Cachable {
    let id: String
}

class FlatCacheTests: XCTestCase {
    
    func test_whenSettingSingleModel_thatResultExistsForType() {
        let cache = FlatCache()
        cache.set(value: CacheModel(id: "1", value: ""))
        XCTAssertNotNil(cache.get(id: "1") as CacheModel?)
    }

    func test_whenSettingSingleModel_withUupdatedModel_thatResultMostRecent() {
        let cache = FlatCache()
        cache.set(value: CacheModel(id: "1", value: "foo"))
        cache.set(value: CacheModel(id: "1", value: "bar"))
        XCTAssertEqual((cache.get(id: "1") as CacheModel?)?.value, "bar")
    }

    func test_whenSettingSingleModel_thatNoResultExsistForUnsetId() {
        let cache = FlatCache()
        cache.set(value: CacheModel(id: "1", value: ""))
        XCTAssertNil(cache.get(id: "2") as CacheModel?)
    }

    func test_whenSettingSingleModel_thatNoResultExistsForOtherType() {
        let cache = FlatCache()
        cache.set(value: CacheModel(id: "1", value: ""))
        XCTAssertNil(cache.get(id: "1") as OtherCacheModel?)
    }

    func test_whenSettingManyModels_thatResultsExistForType() {
        let cache = FlatCache()
        cache.set(values: [
            CacheModel(id: "1", value: ""),
            CacheModel(id: "2", value: ""),
            CacheModel(id: "3", value: ""),
            ])
        XCTAssertNotNil(cache.get(id: "1") as CacheModel?)
        XCTAssertNotNil(cache.get(id: "2") as CacheModel?)
        XCTAssertNotNil(cache.get(id: "3") as CacheModel?)
    }

    func test_whenSettingSingleModel_withListeners_whenMultipleUpdates_thatCorrectListenerReceivesUpdate() {
        let cache = FlatCache()
        let l1 = CacheModelListener()
        let l2 = CacheModelListener()
        let m1 = CacheModel(id: "1", value: "")
        let m2 = CacheModel(id: "2", value: "")
        cache.add(listener: l1, value: m1)
        cache.add(listener: l2, value: m2)
        cache.set(value: m1)
        cache.set(value: CacheModel(id: "1", value: "foo"))
        XCTAssertEqual(l1.receivedItemQueue.count, 2)
        XCTAssertEqual(l1.receivedItemQueue.last?.id, "1")
        XCTAssertEqual(l1.receivedItemQueue.last?.value, "foo")
        XCTAssertEqual(l2.receivedListQueue.count, 0)
        XCTAssertEqual(l2.receivedListQueue.count, 0)
    }
    
}
