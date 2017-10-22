//
//  SearchEmptyViewTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import Freetime
class SearchEmptyViewTests: XCTestCase {

    var searchEmptyView: SearchEmptyView!
    var mockDelegate: MockSearchEmptyViewDelegate!

    override func setUp() {
        super.setUp()
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        mockDelegate = MockSearchEmptyViewDelegate()
        searchEmptyView = SearchEmptyView(frame: frame)
        searchEmptyView.delegate = mockDelegate
    }

    func test_onTap() {
        searchEmptyView.onTap()
        XCTAssertTrue(mockDelegate.didTap)
    }

}
