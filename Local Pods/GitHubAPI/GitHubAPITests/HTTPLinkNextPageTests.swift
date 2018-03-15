//
//  HTTPLinkNextPageTests.swift
//  GitHubAPITests
//
//  Created by Ryan Nystrom on 3/3/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest

@testable import GitHubAPI

class HTTPLinkNextPageTests: XCTestCase {
    
    func test_linkExists() {
        let str = "<https://api.github.com/notifications?per_page=100&access_token=abc&all=true&page=2&participating=false>; rel=\"next\", <https://api.github.com/notifications?per_page=100&access_token=abc&all=true&page=4&participating=false>; rel=\"last\""
        XCTAssertEqual(str.httpNextPageNumber, 2)
    }

    func test_linkNil_whenNextMissing() {
        let str = "<https://api.github.com/notifications?per_page=100&access_token=abc&all=true&page=2&participating=false>; rel=\"miss\", <https://api.github.com/notifications?per_page=100&access_token=abc&all=true&page=4&participating=false>; rel=\"last\""
        XCTAssertNil(str.httpNextPageNumber)
    }

    func test_linkNil_whenEmpty() {
        let str = ""
        XCTAssertNil(str.httpNextPageNumber)
    }
    
}
