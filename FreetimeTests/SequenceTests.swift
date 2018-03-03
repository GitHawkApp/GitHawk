//
//  SequenceTests.swift
//  FreetimeTests
//
//  Created by Bas Broek on 04/03/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class SequenceTests: XCTestCase {

    func test_containsAll() {
        XCTAssertTrue(["a", "a", "a"].containsAll("a"))
        XCTAssertFalse(["b", "a", "a"].containsAll("a"))
        XCTAssertFalse(["a", "a", "a"].containsAll("b"))

        XCTAssertTrue(["a", "a", "a"].containsAll { $0 == "a" })
        XCTAssertFalse(["b", "a", "a"].containsAll { $0 == "a" })
        XCTAssertFalse(["a", "a", "a"].containsAll { $0 == "b" })

        XCTAssertTrue([1, 1, 1].containsAll(1))
        XCTAssertFalse([2, 1, 1].containsAll(1))
        XCTAssertFalse([1, 1, 1].containsAll(2))

        XCTAssertTrue([1, 1, 1].containsAll { $0 == 1 })
        XCTAssertFalse([2, 1, 1].containsAll { $0 == 1 })
        XCTAssertFalse([1, 1, 1].containsAll { $0 == 2 })
    }

    func test_containsNone() {
        XCTAssertFalse(["a", "a", "a"].containsNone("a"))
        XCTAssertFalse(["b", "a", "a"].containsNone("a"))
        XCTAssertTrue(["a", "a", "a"].containsNone("b"))

        XCTAssertFalse(["a", "a", "a"].containsNone { $0 == "a" })
        XCTAssertFalse(["b", "a", "a"].containsNone { $0 == "a" })
        XCTAssertTrue(["a", "a", "a"].containsNone { $0 == "b" })

        XCTAssertFalse([1, 1, 1].containsNone(1))
        XCTAssertFalse([2, 1, 1].containsNone(1))
        XCTAssertTrue([1, 1, 1].containsNone(2))

        XCTAssertFalse([1, 1, 1].containsNone { $0 == 1 })
        XCTAssertFalse([2, 1, 1].containsNone { $0 == 1 })
        XCTAssertTrue([1, 1, 1].containsNone { $0 == 2 })
    }

    func test_emptySequence() {
        let emptyStrings: [String] = []
        let emptyInts: [Int] = []

        XCTAssertTrue(emptyStrings.containsNone("a"))
        XCTAssertTrue(emptyStrings.containsNone { $0 == "a" })
        XCTAssertFalse(emptyStrings.containsAll("a"))
        XCTAssertFalse(emptyStrings.containsAll { $0 == "a" })

        XCTAssertTrue(emptyInts.containsNone(1))
        XCTAssertTrue(emptyInts.containsNone { $0 == 1 })
        XCTAssertFalse(emptyInts.containsAll(1))
        XCTAssertFalse(emptyInts.containsAll { $0 == 1 })
    }
}
