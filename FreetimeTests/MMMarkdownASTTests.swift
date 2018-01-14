//
//  MMMarkdownASTTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

final class MMMarkdownASTTests: XCTestCase {

    var testMarkdown: String {
        let url = Bundle(for: MMMarkdownASTTests.self).url(forResource: "Test", withExtension: "md")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }

    func test_fileExists() {
        XCTAssertTrue(testMarkdown.count > 0)
    }

    func test_createASTWorks() {
        let document = createCommentAST(markdown: testMarkdown, owner: "testowner", repository: "testrepo")
        XCTAssertNotNil(document)
        XCTAssertTrue(document!.elements.count > 0)
    }

    func test_creatingTestMarkdownWorks() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let result = CreateCommentModels(markdown: testMarkdown, width: 300, options: options)
        XCTAssertTrue(result.count > 0)
    }

    func test_plainText() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let result = CreateCommentModels(markdown: "foo", width: 300, options: options)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo")
    }

    func test_paragraphWithBold() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let result = CreateCommentModels(markdown: "foo **bar**", width: 300, options: options)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo bar")
    }

    func test_paragraphWithItalics() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let result = CreateCommentModels(markdown: "foo _bar_", width: 300, options: options)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo bar")
    }

    func DISABLED_test_nestedLists() {
        let md = [
            "- 1.1 _italic_",
            "- 1.2 **bold**",
            "    - 2.1",
            "- 1.3"
            ].joined(separator: "\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let result = CreateCommentModels(markdown: md, width: 300, options: options)

        // MMMarkdown puts an extra "\n" after **bold** as an entity type. TODO
        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "\u{2022} 1.1 italic\n\u{2022} 1.2 bold\n\u{2022} 2.1\n\u{2022} 1.3")
    }

    func test_listWithNewlinesBetween() {
        let markdown = "1. line 1\n\n2. line 2"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let result = CreateCommentModels(markdown: markdown, width: 300, options: options)
        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "1. line 1\n2. line 2")
    }

    func test_usernames() {
        let markdown = "@user not @user\n@user user@gmail.com and @user"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [.usernames])
        let result = CreateCommentModels(markdown: markdown, width: 300, options: options)
        XCTAssertEqual(result.count, 1)
        let text = result.first as! NSAttributedStringSizing
        XCTAssertNotNil(text.attributedText.attributes(at: 0, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributedText.attributes(at: 3, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNil(text.attributedText.attributes(at: 8, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributedText.attributes(at: 13, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributedText.attributes(at: 18, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNil(text.attributedText.attributes(at: 23, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNil(text.attributedText.attributes(at: 30, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributedText.attributes(at: 45, effectiveRange: nil)[MarkdownAttribute.username])
    }

    func test_shortlinks() {
        let markdown = "#123 test #123 #abc abc#123 and foo/bar#456 end"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [.issueShorthand])
        let result = CreateCommentModels(markdown: markdown, width: 300, options: options)
        XCTAssertEqual(result.count, 1)
        let text = result.first as! NSAttributedStringSizing
        XCTAssertNotNil(text.attributedText.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 6, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributedText.attributes(at: 12, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 17, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 25, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 30, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributedText.attributes(at: 34, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributedText.attributes(at: 41, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 45, effectiveRange: nil)[MarkdownAttribute.issue])

        let details = text.attributedText.attributes(at: 12, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(details.owner, "owner")
        XCTAssertEqual(details.repo, "repo")
        XCTAssertEqual(details.number, 123)

        let comboDetails = text.attributedText.attributes(at: 34, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(comboDetails.owner, "foo")
        XCTAssertEqual(comboDetails.repo, "bar")
        XCTAssertEqual(comboDetails.number, 456)
    }

    func test_shortenLinks() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [.issueShorthand])

        // Test Same Repository
        let testOne = "https://github.com/owner/repo/issues/123"
        let resultOne = CreateCommentModels(markdown: testOne, width: 300, options: options)
        let textOne = resultOne.first as! NSAttributedStringSizing
        XCTAssertEqual(textOne.attributedText.string, "#123")
        XCTAssertNotNil(textOne.attributedText.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue])

        let detailsOne = textOne.attributedText.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(detailsOne.owner, "owner")
        XCTAssertEqual(detailsOne.repo, "repo")
        XCTAssertEqual(detailsOne.number, 123)

        // Test Cross Repository
        let testTwo = "https://github.com/differentOwner/differentRepo/issues/321"
        let resultTwo = CreateCommentModels(markdown: testTwo, width: 300, options: options)
        let textTwo = resultTwo.first as! NSAttributedStringSizing
        XCTAssertEqual(textTwo.attributedText.string, "differentOwner/differentRepo#321")
        XCTAssertNotNil(textTwo.attributedText.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue])

        let detailsTwo = textTwo.attributedText.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(detailsTwo.owner, "differentOwner")
        XCTAssertEqual(detailsTwo.repo, "differentRepo")
        XCTAssertEqual(detailsTwo.number, 321)
    }

}
