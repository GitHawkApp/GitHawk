//
//  InitialEmptyViewTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest
@testable import Freetime

class InitialEmptyViewTests: XCTestCase {

    var initialEmptyView: InitialEmptyView!
    var mockDelegateObject: MockInitialEmptyViewDelegate!

    override func setUp() {
        super.setUp()
        mockDelegateObject = MockInitialEmptyViewDelegate()
        initialEmptyView = InitialEmptyView()
        initialEmptyView.configure(imageName: "repo", title: "repo", description: "repo")
        initialEmptyView.delegate = mockDelegateObject
    }

    func test_onTap() {
        initialEmptyView.onTap()
        XCTAssertTrue(mockDelegateObject.didTap)
    }

}
