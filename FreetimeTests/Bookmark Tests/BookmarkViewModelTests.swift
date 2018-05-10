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

    var bookmark: Bookmark!
    var bookmarkViewModel: BookmarkViewModel!

    func test_bookmarkText_issue() {
        bookmark = Bookmark(type: .issue, name: "IGListKit on Bookmarks", owner: "rizwankce", title: "Bookmarks view controller not using IGLK")
        bookmarkViewModel = BookmarkViewModel(bookmark: bookmark, contentSizeCategory: .large, width: 0)
        XCTAssertEqual(bookmark.title, bookmarkViewModel.text.string.allText)
    }

    func test_bookmarkText_pullRequest() {
        bookmark = Bookmark(type: .pullRequest, name: "Implemented Bookmark ViewModel", owner: "heshamsalman")
        bookmarkViewModel = BookmarkViewModel(bookmark: bookmark, contentSizeCategory: .large, width: 0)
        XCTAssertEqual(bookmark.title, bookmarkViewModel.text.string.allText)
    }

    func test_bookmarkText_repository() {
        bookmark = Bookmark(type: .repo, name: "GitHawk", owner: "GitHawkApp")
        bookmarkViewModel = BookmarkViewModel(bookmark: bookmark, contentSizeCategory: .large, width: 0)
        XCTAssertEqual("\(bookmark.owner)/\(bookmark.name)", bookmarkViewModel.text.string.allText)
    }

}
