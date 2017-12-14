//
//  UIContentSizeCategoryScalingTests.swift
//  StyledTextTests
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import StyledText

class UIContentSizeCategoryScalingTests: XCTestCase {
    
    func test_whenBetweenMinAndMax_thatOriginalReturned() {
        let result = UIContentSizeCategory.large.preferredContentSize(12, minSize: 11, maxSize: 13)
        XCTAssertEqual(result, 12)
    }

    func test_whenNoMinAndMax_thatOriginalReturned() {
        let result = UIContentSizeCategory.large.preferredContentSize(12)
        XCTAssertEqual(result, 12)
    }

    func test_whenBeyondMax_thatMaxReturned() {
        let result = UIContentSizeCategory.large.preferredContentSize(14, minSize: 11, maxSize: 13)
        XCTAssertEqual(result, 13)
    }

    func test_whenUnderMin_thatMinReturned() {
        let result = UIContentSizeCategory.large.preferredContentSize(10, minSize: 11, maxSize: 13)
        XCTAssertEqual(result, 11)
    }

}
