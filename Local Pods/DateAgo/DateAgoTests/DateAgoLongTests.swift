//
//  DateAgoShortTests.swift
//  DateAgoTests
//
//  Created by Ryan Nystrom on 4/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import DateAgo

class DateAgoShortTests: XCTestCase {
    
    class DateDisplayTests: XCTestCase {

        func test_whenDateFuture() {
            let result = Date(timeIntervalSinceNow: 10).agoString(.short)
            XCTAssertEqual(result, "in the future")
        }

        func test_whenDateSeconds() {
            let result = Date(timeIntervalSinceNow: -5).agoString(.short)
            XCTAssertEqual(result, "just now")
        }

        func test_whenDateMinutes_withLowerBound_withSingular() {
            let result = Date(timeIntervalSinceNow: -61).agoString(.short)
            XCTAssertEqual(result, "1m")
        }

        func test_whenDateMinutes_withUpperBound_withDecimal_withSingular() {
            let result = Date(timeIntervalSinceNow: -59.5).agoString(.short)
            XCTAssertEqual(result, "1m")
        }

        func test_whenDateMinutes_withUpperBound_withPlural() {
            let result = Date(timeIntervalSinceNow: -119).agoString(.short)
            XCTAssertEqual(result, "2m")
        }

        func test_whenDateHour_withLowerBound_withSingular() {
            let result = Date(timeIntervalSinceNow: -3601).agoString(.short)
            XCTAssertEqual(result, "1h")
        }

        func test_whenDateHour_withUpperBound_withDecimal_withSingular() {
            let result = Date(timeIntervalSinceNow: -3599.5).agoString(.short)
            XCTAssertEqual(result, "1h")
        }

        func test_whenDateHours_withUpperBound_withPlural() {
            let result = Date(timeIntervalSinceNow: -7199).agoString(.short)
            XCTAssertEqual(result, "2h")
        }

        func test_whenDateDay_withLowerBound_withSingular() {
            let result = Date(timeIntervalSinceNow: -86401).agoString(.short)
            XCTAssertEqual(result, "1d")
        }

        func test_whenDateDay_withUpperBound_withDecimal_withSingular() {
            let result = Date(timeIntervalSinceNow: -86399.5).agoString(.short)
            XCTAssertEqual(result, "1d")
        }

        func test_whenDateDay_withUpperBound_withPlural() {
            let result = Date(timeIntervalSinceNow: -172799).agoString(.short)
            XCTAssertEqual(result, "2d")
        }

        func test_whenDateMonth_withLowerBound_withSingular() {
            let result = Date(timeIntervalSinceNow: -2592001).agoString(.short)
            XCTAssertEqual(result, "1mo")
        }

        func test_whenDateMonth_withUpperBound_withDecimal_withSingular() {
            let result = Date(timeIntervalSinceNow: -2591999.5).agoString(.short)
            XCTAssertEqual(result, "1mo")
        }

        func test_whenDateMonth_withUpperBound_withPlural() {
            let result = Date(timeIntervalSinceNow: -5183999).agoString(.short)
            XCTAssertEqual(result, "2mo")
        }

        func test_whenDateYear_withLowerBound_withSingular() {
            let result = Date(timeIntervalSinceNow: -31104001).agoString(.short)
            XCTAssertEqual(result, "1y")
        }

        func test_whenDateYear_withUpperBound_withDecimal_withSingular() {
            let result = Date(timeIntervalSinceNow: -31103999.5).agoString(.short)
            XCTAssertEqual(result, "1y")
        }

        func test_whenDateYear_withUpperBound_withPlural() {
            let result = Date(timeIntervalSinceNow: -62207999).agoString(.short)
            XCTAssertEqual(result, "2y")
        }

    }
    
}
