//
//  DateDisplayTests.swift
//  DateDisplayTests
//
//  Created by Ryan Nystrom on 5/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class DateDisplayTests: XCTestCase {
    
    func test_whenDateFuture() {
        let result = Date(timeIntervalSinceNow: 10).agoString
        XCTAssertEqual(result, "in the future")
    }

    func test_whenDateSeconds() {
        let result = Date(timeIntervalSinceNow: -5).agoString
        XCTAssertEqual(result, "just now")
    }

    func test_whenDateMinutes_withLowerBound_withSingular() {
        let result = Date(timeIntervalSinceNow: -61).agoString
        XCTAssertEqual(result, "1 minute ago")
    }

    func test_whenDateMinutes_withUpperBound_withDecimal_withPlural() {
        let result = Date(timeIntervalSinceNow: -59.5).agoString
        XCTAssertEqual(result, "1 minute ago")
    }

    func test_whenDateMinutes_withUpperBound_withPlural() {
        let result = Date(timeIntervalSinceNow: -119).agoString
        XCTAssertEqual(result, "2 minutes ago")
    }

    func test_whenDateHour_withLowerBound_withSingular() {
        let result = Date(timeIntervalSinceNow: -3601).agoString
        XCTAssertEqual(result, "1 hour ago")
    }

    func test_whenDateHours_withUpperBound_withPlural() {
        let result = Date(timeIntervalSinceNow: -7199).agoString
        XCTAssertEqual(result, "2 hours ago")
    }

    func test_whenDateDay_withLowerBound_withSingular() {
        let result = Date(timeIntervalSinceNow: -86401).agoString
        XCTAssertEqual(result, "1 day ago")
    }

    func test_whenDateDay_withUpperBound_withPlural() {
        let result = Date(timeIntervalSinceNow: -172799).agoString
        XCTAssertEqual(result, "2 days ago")
    }

    func test_whenDateMonth_withLowerBound_withSingular() {
        let result = Date(timeIntervalSinceNow: -2592001).agoString
        XCTAssertEqual(result, "1 month ago")
    }

    func test_whenDateMonth_withUpperBound_withPlural() {
        let result = Date(timeIntervalSinceNow: -5183999).agoString
        XCTAssertEqual(result, "2 months ago")
    }

    func test_whenDateYear_withLowerBound_withSingular() {
        let result = Date(timeIntervalSinceNow: -31104001).agoString
        XCTAssertEqual(result, "1 year ago")
    }

    func test_whenDateYear_withUpperBound_withPlural() {
        let result = Date(timeIntervalSinceNow: -62207999).agoString
        XCTAssertEqual(result, "2 years ago")
    }
    
}
