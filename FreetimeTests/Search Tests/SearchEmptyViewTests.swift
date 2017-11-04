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

    var InitialEmptyView: InitialEmptyView!
    var mockDelegate: MockInitialEmptyViewDelegate!

    override func setUp() {
        super.setUp()
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mockDelegate = MockInitialEmptyViewDelegate()
        InitialEmptyView = InitialEmptyView(frame: frame)
        InitialEmptyView.delegate = mockDelegate
    }

    func test_onTap() {
        InitialEmptyView.onTap()
        XCTAssertTrue(mockDelegate.didTap)
    }

}
