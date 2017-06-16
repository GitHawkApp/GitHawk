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
        let result = commentModels(markdown: testMarkdown, width: 300)
        XCTAssertTrue(result.count > 0)
    }

    func test_plainText() {
        let result = commentModels(markdown: "foo", width: 300)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo")
    }

    func test_paragraphWithBold() {
        let result = commentModels(markdown: "foo **bar**", width: 300)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo bar")
    }

    func test_paragraphWithItalics() {
        let result = commentModels(markdown: "foo _bar_", width: 300)
        XCTAssertEqual(result.count, 1)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "foo bar")
    }

    func test_nestedLists() {
        let md = [
            "- 1.1 _italic_",
            "- 1.2 **bold**",
            "    - 2.1",
            "- 1.3",
            ].joined(separator: "\n")
        let result = commentModels(markdown: md, width: 300)

        let text = result.first as! NSAttributedStringSizing
        XCTAssertEqual(text.attributedText.string, "\u{2022} 1.1 italic\n\u{2022} 1.2 bold\n\u{2022} 2.1\n\u{2022} 1.3")
    }

}
