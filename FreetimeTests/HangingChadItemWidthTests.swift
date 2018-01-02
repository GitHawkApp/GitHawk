//
//  HangingChadItemWidthTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 1/1/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest

class HangingChadItemWidthTests: XCTestCase {
    
    func test_whenCountEmpty() {
        XCTAssertEqual(HangingChadItemWidth(index: 0, count: 0, containerWidth: 300, desiredItemWidth: 30), 0)
    }

    func test_whenIndexOOB() {
        XCTAssertEqual(HangingChadItemWidth(index: 3, count: 2, containerWidth: 300, desiredItemWidth: 30), 0)
    }

    func test_whenCountOne_withDesiredWidthLessThanContainer() {
        XCTAssertEqual(HangingChadItemWidth(index: 0, count: 1, containerWidth: 300, desiredItemWidth: 30), 300)
    }

    func test_whenIndexLessThanCount_withDesiredWidthLessThanContainer() {
        XCTAssertEqual(HangingChadItemWidth(index: 0, count: 2, containerWidth: 300, desiredItemWidth: 30), 150)
    }

    func test_whenIndexZero_withSingleRow() {
        XCTAssertEqual(HangingChadItemWidth(index: 0, count: 10, containerWidth: 300, desiredItemWidth: 30), 30)
    }

    func test_whenIndexLessThanCount_withSingleRow() {
        XCTAssertEqual(HangingChadItemWidth(index: 5, count: 10, containerWidth: 300, desiredItemWidth: 30), 30)
    }

    func test_whenIndexZero_withTwoRows() {
        XCTAssertEqual(HangingChadItemWidth(index: 0, count: 20, containerWidth: 300, desiredItemWidth: 30), 30)
    }

    func test_whenIndexFirstRow_withTwoRows() {
        XCTAssertEqual(HangingChadItemWidth(index: 5, count: 20, containerWidth: 300, desiredItemWidth: 30), 30)
    }

    func test_whenIndexSecondRow_withTwoRows() {
        XCTAssertEqual(HangingChadItemWidth(index: 15, count: 20, containerWidth: 300, desiredItemWidth: 30), 30)
    }

    func test_whenTwoRows_withSingleItems_withIndexZero() {
        XCTAssertEqual(HangingChadItemWidth(index: 0, count: 2, containerWidth: 300, desiredItemWidth: 300), 300)
    }

    func test_whenTwoRows_withSingleItems_withIndexOne() {
        XCTAssertEqual(HangingChadItemWidth(index: 1, count: 2, containerWidth: 300, desiredItemWidth: 300), 300)
    }

    func test_whenTwoRows_withHangingChad_withIndexZero() {
        XCTAssertEqual(HangingChadItemWidth(index: 0, count: 21, containerWidth: 300, desiredItemWidth: 30), 30)
    }

    func test_whenTwoRows_withHangingChad_withSecondLastIndex() {
        XCTAssertEqual(HangingChadItemWidth(index: 19, count: 21, containerWidth: 300, desiredItemWidth: 30), 150)
    }

    func test_whenTwoRows_withHangingChad_withLastIndex() {
        XCTAssertEqual(HangingChadItemWidth(index: 20, count: 21, containerWidth: 300, desiredItemWidth: 30), 150)
    }
    
}
