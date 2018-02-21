//
//  GraphQLIDDecodeTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 9/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class GraphQLIDDecodeTests: XCTestCase {

    func test_whenDecodingIssueComment_thatNumberReturned() {
        let result = GraphQLIDDecode(id: "MDEyOklzc3VlQ29tbWVudDMzMTY2OTI5OA==", separator: "IssueComment")
        XCTAssertEqual(result, 331669298)
    }

}
