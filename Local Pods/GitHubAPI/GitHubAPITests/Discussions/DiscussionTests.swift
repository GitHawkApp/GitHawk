//
//  DiscussionTests.swift
//  GitHubAPITests
//
//  Created by Bas Broek on 28/07/2018.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import GitHubAPI

class DiscussionTests: XCTestCase {
    func test_listDiscissions() {
        let data = try! Data(contentsOf: Bundle(for: type(of: self)).url(forResource: "discussions", withExtension: "json")!)
        let result = processResponse(request: V3DiscussionsRequest(teamID: 2343027, page: 1), input: data)
        switch result {
        case .failure(let error): XCTFail(error?.localizedDescription ?? "Failed without error")
        case .success(let response):
            XCTAssertEqual(response.data.count, 1)

            let first = response.data.first!
            XCTAssertEqual(first.number, 1)
            XCTAssertEqual(first.author.login, "octocat")
            XCTAssertEqual(first.title, "Our first team post")
            XCTAssertEqual(first.body, "<p>Hi! This is an area for us to collaborate as a team</p>")
            XCTAssertEqual(first.commentsCount, 0)
            XCTAssertFalse(first.hasComments)
            XCTAssertFalse(first.isPinned)
            XCTAssertFalse(first.isPrivate)
            XCTAssertEqual(first.webURL, URL(string: "https://github.com/orgs/github/teams/justice-league/discussions/1"))
        }
    }
}
