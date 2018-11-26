//
//  SortUsers.swift
//  FreetimeTests
//
//  Created by B_Litwin on 10/8/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime
@testable import GitHubAPI

class SortUsers: XCTestCase {

    func makeUser(_ name: String) -> V3User {
        return V3User(
            avatarUrl: URL(string: "github.com")!,
            id: 1,
            login: name,
            siteAdmin: false,
            type: .user
        )
    }

    func test_SortWithCurrentUserFirst() {

        var users = [
            "A_rnystrom",
            "B_basthomas",
            "C_Sherlouk"
            ].map(makeUser)

        var sorted = PeopleViewController.sortUsers(
            users: users,
            currentUser: "B_basthomas"
        )

        // sorts the current user first and otherwise sorts alphabetically
        XCTAssertEqual(sorted[0].login, "B_basthomas")
        XCTAssertEqual(sorted[1].login, "A_rnystrom")
        XCTAssertEqual(sorted[2].login, "C_Sherlouk")

        sorted = PeopleViewController.sortUsers(
            users: users,
            currentUser: nil
        )

        XCTAssertEqual(sorted[0].login, "A_rnystrom")
        XCTAssertEqual(sorted[1].login, "B_basthomas")
        XCTAssertEqual(sorted[2].login, "C_Sherlouk")
    }
}
