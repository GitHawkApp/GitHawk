//
//  InboxUITests.swift
//  FreetimeUITests
//
//  Created by Ryan Nystrom on 1/28/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest

class InboxUITests: XCTestCase {

    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = launch(options: [.mockUser])
    }

    func test_tapNotification() {
        app.collectionViews["inbox-collectionView"].cells.firstMatch.tap()
        XCTAssertTrue(app.collectionViews["issues-collectionView"].exists)
    }
    
}
