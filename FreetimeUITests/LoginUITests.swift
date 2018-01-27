//
//  LoginUITests.swift
//  FreetimeUITests
//
//  Created by Ryan Nystrom on 1/27/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        launch(options: [.reset])
    }
    
    func test_loginWithPAT() {
        XCUIApplication().buttons["Personal Token"].tap()

        let personalAccessTokenAlert = XCUIApplication().alerts["Personal Access Token"]
        let personalAccessTokenTextField = personalAccessTokenAlert.textFields["Personal Access Token"]
        personalAccessTokenTextField.tap()

        // mocked network stack should accept any access token
        personalAccessTokenTextField.typeText("1234")
        personalAccessTokenAlert.buttons["Sign in"].tap()

        XCTAssertFalse(XCUIApplication().buttons["Personal Token"].exists)
        XCTAssertTrue(XCUIApplication().navigationBars["Inbox"].exists)
    }
    
}
