//
//  MMMarkdownASTTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
import StyledText
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
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)
        let result = CreateCommentModels(markdown: testMarkdown, options: options)
        XCTAssertTrue(result.count > 0)
    }

    func test_plainText() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)
        let result = CreateCommentModels(markdown: "foo", options: options)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! StyledTextRenderer
        XCTAssertEqual(text.string.allText, "foo")
    }

    func test_paragraphWithBold() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)
        let result = CreateCommentModels(markdown: "foo **bar**", options: options)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! StyledTextRenderer
        XCTAssertEqual(text.string.allText, "foo bar")
    }

    func test_paragraphWithItalics() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)
        let result = CreateCommentModels(markdown: "foo _bar_", options: options)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! StyledTextRenderer
        XCTAssertEqual(text.string.allText, "foo bar")
    }

    func test_listWithNewlinesBetween() {
        let markdown = "1. line 1\n\n2. line 2"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)
        let result = CreateCommentModels(markdown: markdown, options: options)
        let text = result.first as! StyledTextRenderer
        XCTAssertEqual(text.string.allText, "1. line 1\n2. line 2")
    }

    func test_usernames() {
        let markdown = "@user not @user\n@user user@gmail.com and @user"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)
        let result = CreateCommentModels(markdown: markdown, options: options)
        XCTAssertEqual(result.count, 1)
        let text = (result.first as! StyledTextRenderer).string.render(contentSizeCategory: .large)
        XCTAssertNotNil(text.attributes(at: 0, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributes(at: 3, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNil(text.attributes(at: 8, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributes(at: 13, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributes(at: 18, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNil(text.attributes(at: 23, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNil(text.attributes(at: 30, effectiveRange: nil)[MarkdownAttribute.username])
        XCTAssertNotNil(text.attributes(at: 45, effectiveRange: nil)[MarkdownAttribute.username])
    }

    func test_shortlinks() {
        let markdown = "#123 test #123 #abc abc#123 and foo/bar#456 end"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)
        let result = CreateCommentModels(markdown: markdown, options: options)
        XCTAssertEqual(result.count, 1)
        let text = (result.first as! StyledTextRenderer).string.render(contentSizeCategory: .large)
        XCTAssertNotNil(text.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributes(at: 6, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributes(at: 12, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributes(at: 17, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributes(at: 25, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributes(at: 30, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributes(at: 34, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributes(at: 41, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributes(at: 45, effectiveRange: nil)[MarkdownAttribute.issue])

        let details = text.attributes(at: 12, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(details.owner, "owner")
        XCTAssertEqual(details.repo, "repo")
        XCTAssertEqual(details.number, 123)

        let comboDetails = text.attributes(at: 34, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(comboDetails.owner, "foo")
        XCTAssertEqual(comboDetails.repo, "bar")
        XCTAssertEqual(comboDetails.number, 456)
    }

    func test_shortenLinks() {
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [], width: 0, contentSizeCategory: .large)

        // Test Same Repository
        let testOne = "https://github.com/owner/repo/issues/123"
        let resultOne = CreateCommentModels(markdown: testOne, options: options)
        let textOne = resultOne.first as! StyledTextRenderer
        XCTAssertEqual(textOne.string.allText, "#123")
        let attrOne = textOne.string.render(contentSizeCategory: .large)
        XCTAssertNotNil(attrOne.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue])

        let detailsOne = attrOne.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(detailsOne.owner, "owner")
        XCTAssertEqual(detailsOne.repo, "repo")
        XCTAssertEqual(detailsOne.number, 123)

        // Test Cross Repository
        let testTwo = "https://github.com/differentOwner/differentRepo/issues/321"
        let resultTwo = CreateCommentModels(markdown: testTwo, options: options)
        let textTwo = resultTwo.first as! StyledTextRenderer
        XCTAssertEqual(textTwo.string.allText, "differentOwner/differentRepo#321")

        let attrTwo = textTwo.string.render(contentSizeCategory: .large)
        XCTAssertNotNil(attrTwo.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue])

        let detailsTwo = attrTwo.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue] as! IssueDetailsModel
        XCTAssertEqual(detailsTwo.owner, "differentOwner")
        XCTAssertEqual(detailsTwo.repo, "differentRepo")
        XCTAssertEqual(detailsTwo.number, 321)
    }

}
