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
        let result = CreateCommentModels(markdown: testMarkdown, width: 300)
        XCTAssertTrue(result.count > 0)
    }

    func test_plainText() {
        let result = CreateCommentModels(markdown: "foo", width: 300)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo")
    }

    func test_paragraphWithBold() {
        let result = CreateCommentModels(markdown: "foo **bar**", width: 300)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo bar")
    }

    func test_paragraphWithItalics() {
        let result = CreateCommentModels(markdown: "foo _bar_", width: 300)
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
        let result = CreateCommentModels(markdown: md, width: 300)

        // MMMarkdown puts an extra "\n" after **bold** as an entity type. TODO
        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "\u{2022} 1.1 italic\n\u{2022} 1.2 bold\n\u{2022} 2.1\n\u{2022} 1.3")
    }

    func test_listWithNewlinesBetween() {
        let markdown = "1. line 1\n\n2. line 2"
        let result = CreateCommentModels(markdown: markdown, width: 300)
        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "1. line 1\n2. line 2")
    }

    func test_usernames() {
        let markdown = "@user not @user\n@user user@gmail.com and @user"
        let result = CreateCommentModels(markdown: markdown, width: 300)
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

}
