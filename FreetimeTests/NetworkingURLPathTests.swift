//
//  NetworkingURLPathTests.swift
//  FreetimeTests
//
//  Created by B_Litwin on 5/25/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import GitHubAPI
import XCTest
@testable import Freetime

class UrlPathComponents: XCTestCase {
    //Issue #1829: add reviewers was receiving a 404 response
    
    func test_addReviewers() {
        let addReviewersRequest = V3AddPeopleRequest(owner: "GitHawkApp",
                                                     repo: "GitHawk",
                                                     number: 1549,
                                                     type: .reviewers,
                                                     add: true,
                                                     people: [])
        XCTAssertEqual(addReviewersRequest.url,
                       "https://api.github.com/repos/GitHawkApp/GitHawk/pulls/1549/requested_reviewers")
    }
    
    func test_addAssignees() {
        let addAssigneesRequest = V3AddPeopleRequest(owner: "GitHawkApp",
                                                     repo: "GitHawk",
                                                     number: 1549,
                                                     type: .assignees,
                                                     add: true,
                                                     people: [])
        
        XCTAssertEqual(addAssigneesRequest.url,
                       "https://api.github.com/repos/GitHawkApp/GitHawk/issues/1549/assignees")
    }
}

