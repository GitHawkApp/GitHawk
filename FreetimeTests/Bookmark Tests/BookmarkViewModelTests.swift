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
        issueModel = BookmarkViewModel(bookmark: issue, width: 0)

        other = Bookmark(type: .commit, name: "Implemented Bookmark ViewModel", owner: "heshamsalman")
        otherModel = BookmarkViewModel(bookmark: other, width: 0)
    }

    func test_bookmarkText_issue() {
        let string = NSMutableAttributedString(attributedString: RepositoryAttributedString(owner: issue.owner, name: issue.name))
        string.append(
                NSAttributedString(string: "#\(issue.number)", attributes: [
                    .font: Styles.Fonts.body,
                    .foregroundColor: Styles.Colors.Gray.medium.color
                    ]
                )
        )
        string.append(NSAttributedString(string: "\n" + issue.title, attributes: [
            .font: Styles.Fonts.secondary,
            .foregroundColor: Styles.Colors.Gray.medium.color
            ])
        )
        let expected = NSAttributedStringSizing(containerWidth: 0, attributedText: string, inset: BookmarkCell.titleInset)
        let actual = issueModel.text

        XCTAssertEqual(expected.attributedText, actual.attributedText)
    }

    func test_bookmarkText_other() {
        let string = NSMutableAttributedString(attributedString: RepositoryAttributedString(owner: other.owner, name: other.name))
        let expected = NSAttributedStringSizing(containerWidth: 0, attributedText: string, inset: BookmarkCell.titleInset)
        let actual = otherModel.text

        XCTAssertEqual(expected.attributedText, actual.attributedText)
    }

}
