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

        issue = Bookmark(type: .issue, name: "IGListKit on Bookmarks", owner: "rizwankce")
        issueModel = BookmarkViewModel(bookmark: issue)

        other = Bookmark(type: .commit, name: "Implemented Bookmark ViewModel", owner: "heshamsalman")
        otherModel = BookmarkViewModel(bookmark: other)
    }

    func test_repositoryName_issue() {
        let expected = NSMutableAttributedString(attributedString: RepositoryAttributedString(owner: issue.owner, name: issue.name))
        expected.append(
                NSAttributedString(string: "#\(issue.number)", attributes: [
                    .font: Styles.Fonts.body,
                    .foregroundColor: Styles.Colors.Gray.dark.color
                    ]
                )
        )
        let actual = issueModel.repositoryName

        XCTAssertEqual(expected, actual)
    }

    func test_repositoryName_other() {
        let expected = NSMutableAttributedString(attributedString: RepositoryAttributedString(owner: other.owner, name: other.name))
        let actual = otherModel.repositoryName

        XCTAssertEqual(expected, actual)
    }

    func test_bookmarkTitle_issue() {
        let expected = issue.title
        let actual = issueModel.bookmarkTitle

        XCTAssertEqual(expected, actual)
    }

    func test_bookmarkTitle_other() {
        let expected = other.title
        let actual = otherModel.bookmarkTitle

        XCTAssertEqual(expected, actual)
    }

    func test_icon_issue() {
        let expected = issue.type.icon.withRenderingMode(.alwaysTemplate)
        let actual = issueModel.icon

        XCTAssertEqual(expected, actual)
    }

    func test_icon_other() {
        let expected = other.type.icon.withRenderingMode(.alwaysTemplate)
        let actual = otherModel.icon

        XCTAssertEqual(expected, actual)
    }
}
