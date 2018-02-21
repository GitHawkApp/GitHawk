//
//  BookmarkViewModelTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import GitHawk
class BookmarkViewModelTests: XCTestCase {

    var issue: Bookmark!
    var other: Bookmark!

    var issueModel: BookmarkViewModel!
    var otherModel: BookmarkViewModel!

    override func setUp() {
        super.setUp()

        issue = Bookmark(type: .issue, name: "IGListKit on Bookmarks", owner: "rizwankce", title: "Bookmarks view controller not using IGLK")
        issueModel = BookmarkViewModel(bookmark: issue, width: 0)

        other = Bookmark(type: .commit, name: "Implemented Bookmark ViewModel", owner: "heshamsalman")
        otherModel = BookmarkViewModel(bookmark: other, width: 0)
    }

    func test_bookmarkText_other() {
        let string = NSMutableAttributedString(attributedString: RepositoryAttributedString(owner: other.owner, name: other.name))
        let expected = NSAttributedStringSizing(containerWidth: 0, attributedText: string, inset: BookmarkCell.titleInset)
        let actual = otherModel.text

        XCTAssertEqual(expected.attributedText, actual.attributedText)
    }

}
