//
//  BookmarkViewModelTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import Freetime
class BookmarkViewModelTests: XCTestCase {

    var issue: Bookmark!
    var other: Bookmark!

    var issueModel: BookmarkViewModel!
    var otherModel: BookmarkViewModel!

    override func setUp() {
        super.setUp()

        issue = Bookmark(type: .issue, name: "IGListKit on Bookmarks", owner: "rizwankce", title: "Bookmarks view controller not using IGLK")
        issueModel = BookmarkViewModel(bookmark: issue, contentSizeCategory: .large, width: 0)

        other = Bookmark(type: .commit, name: "Implemented Bookmark ViewModel", owner: "heshamsalman")
        otherModel = BookmarkViewModel(bookmark: other, contentSizeCategory: .large, width: 0)
    }

    func test_bookmarkText_other() {
        XCTAssertEqual("\(other.owner)/\(other.name)", otherModel.text.string.allText)
    }

}
