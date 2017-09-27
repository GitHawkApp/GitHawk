//
//  MMMarkdownASTTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 6/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

final class MMMarkdownASTTests: XCTestCase {

    var testMarkdown: String {
        let url = Bundle(for: MMMarkdownASTTests.self).url(forResource: "Test", withExtension: "md")!
        let data = try! Data(contentsOf: url)
        return String(data: data, encoding: .utf8)!
    }

    func test_fileExists() {
        XCTAssertTrue(testMarkdown.characters.count > 0)
    }

    func test_createASTWorks() {
        let document = createCommentAST(markdown: testMarkdown)
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
            "- 1.3",
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
        let markdown = "test #123 #abc abc#123 and GH-3 and owner/repo#123 end"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [.issueShorthand])
        let result = CreateCommentModels(markdown: markdown, width: 300, options: options)
        XCTAssertEqual(result.count, 1)
        let text = result.first as! NSAttributedStringSizing
        XCTAssertNil(text.attributedText.attributes(at: 1, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributedText.attributes(at: 7, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 12, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 20, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 25, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributedText.attributes(at: 29, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributedText.attributes(at: 38, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNotNil(text.attributedText.attributes(at: 49, effectiveRange: nil)[MarkdownAttribute.issue])
        XCTAssertNil(text.attributedText.attributes(at: 52, effectiveRange: nil)[MarkdownAttribute.issue])
    }

}
