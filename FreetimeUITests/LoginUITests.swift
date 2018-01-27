//
//  LoginUITests.swift
//  FreetimeUITests
//
//  Created by Ryan Nystrom on 1/27/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest

class LoginUITests: XCTestCase {

    var app: XCUIApplication!
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = launch(options: [.reset])
    }
    
    func test_loginWithPAT() {
        app.buttons["personal_token"].tap()

        let personalAccessTokenAlert = app.alerts["Personal Access Token"]
        let personalAccessTokenTextField = personalAccessTokenAlert.textFields["Personal Access Token"]
        personalAccessTokenTextField.tap()

        // mocked network stack should accept any access token
        personalAccessTokenTextField.typeText("1234")
        personalAccessTokenAlert.buttons["Sign in"].tap()

        // assert that the login view was dismissed
        XCTAssertFalse(app.buttons["personal_token"].exists)
    }
    
}
