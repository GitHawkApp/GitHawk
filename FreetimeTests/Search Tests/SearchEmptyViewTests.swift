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
    var mockDelegate: MockInitialEmptyViewDelegate!

    override func setUp() {
        super.setUp()
        mockDelegate = MockInitialEmptyViewDelegate()
        initialEmptyView = InitialEmptyView(imageName: "repo", title: "repo", description: "repo")
        initialEmptyView.delegate = mockDelegate
    }

    func test_onTap() {
        initialEmptyView.onTap()
        XCTAssertTrue(mockDelegate.didTap)
    }

}
