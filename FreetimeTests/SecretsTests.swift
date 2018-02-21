//
//  SecretsTests.swift
//  FreetimeTests
//
//  Created by Sherlock, James on 23/11/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import GitHawk

class SecretsTests: XCTestCase {
    
    func testSecrets() {
        // These tests are designed to check (on BuddyBuild) that the environment variables are
        // passed all the way through and can be picked up by this test (and thus the rest of the app)
        //
        // This test will fail locally if you haven't provided the keys, follow the steps in the
        // repo to define these or ignore these tests by de-selecting them via your scheme.
        
        XCTAssertNotEqual(Secrets.GitHub.clientId, "")
        XCTAssertNotEqual(Secrets.GitHub.clientSecret, "")
        XCTAssertNotEqual(Secrets.Imgur.clientId, "")
        
        XCTAssertNotEqual(Secrets.GitHub.clientId, "{GITHUBID}")
        XCTAssertNotEqual(Secrets.GitHub.clientSecret, "{GITHUBSECRET}")
        XCTAssertNotEqual(Secrets.Imgur.clientId, "{IMGURID}")
    }
    
}
