//
//  IssueTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
import StyledTextKit
@testable import Freetime

class IssueTests: XCTestCase {

    func test_whenPluckingSubstringFromRange() {
        let result = "foo ![alt](https://apple.com) bar".substring(with: NSRange(location: 11, length: 17))
        XCTAssertEqual(result, "https://apple.com")
    }

    func test_whenPluckingSubstring_withNewlines() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text"
            ].joined(separator: "\r\n")
        let result = body.substring(with: NSRange(location: 36, length: 17))
        XCTAssertEqual(result, "https://apple.com")
    }

    func test_whenImageInTheMiddle() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text"
            ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "this is the first line\n")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[2] as! StyledTextRenderer).string.allText, "\nthen some more text")
    }

    func test_whenImageAtTheBeginning() {
        let body = [
            "![alt text](https://apple.com)",
            "this is the first line",
            "then some more text"
            ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 2)
        XCTAssertEqual((models[0] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[1] as! StyledTextRenderer).string.allText, "\nthis is the first line\nthen some more text")
    }

    func test_whenImageAtTheEnd() {
        let body = [
            "this is the first line",
            "then some more text",
            "![alt text](https://apple.com)"
            ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 2)
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "this is the first line\nthen some more text\n")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
    }

    func test_whenOnlyOneImage() {
        let body = [
            "![alt text](https://apple.com)"
            ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 1)
        XCTAssertEqual((models[0] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
    }

    func test_whenMultipleImages_withSurroundedByText() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text",
            "![alt text](https://google.com)",
            "foo bar baz"
            ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "this is the first line\n")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[2] as! StyledTextRenderer).string.allText, "\nthen some more text\n")
        XCTAssertEqual((models[3] as! IssueCommentImageModel).url.absoluteString, "https://google.com")
        XCTAssertEqual((models[4] as! StyledTextRenderer).string.allText, "\nfoo bar baz")
    }

    func test_whenCodeBlock_withLanguage_withSurroundedByText() {
        let body = [
            "this is some text",
            "```swift",
            "let a = 5",
            "```",
            "this is the end"
        ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "this is some text")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).code.string.allText, "let a = 5")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).language, "swift")
        XCTAssertEqual((models[2] as! StyledTextRenderer).string.allText, "this is the end")
    }

    func test_whenCodeBlock_withoutLanguage_withSurroundedByText() {
        let body = [
            "this is some text",
            "```",
            "let a = 5",
            "```",
            "this is the end"
            ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "this is some text")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).code.string.allText, "let a = 5")
        XCTAssertNil((models[1] as! IssueCommentCodeBlockModel).language)
        XCTAssertEqual((models[2] as! StyledTextRenderer).string.allText, "this is the end")
    }

    func test_whenImageEmbeddedInCode() {
        let body = [
            "this is the first line",
            "```lang",
            "![alt text](https://apple.com)",
            "```",
            "then some more text",
            "![alt text](https://google.com)",
            "foo bar baz"
            ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "this is the first line")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).language, "lang")
        XCTAssertEqual((models[2] as! StyledTextRenderer).string.allText, "then some more text\n")
        XCTAssertEqual((models[3] as! IssueCommentImageModel).url.absoluteString, "https://google.com")
        XCTAssertEqual((models[4] as! StyledTextRenderer).string.allText, "\nfoo bar baz")
    }

    func test_whenCodePartOfParagraph() {
        let body = "text with ````` inline with ````` more"
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 1)
    }

    func test_whenQuote() {
        let body = [
            "line one",
            "> quote one",
            "\nline two\n",
            ">quote two",
            "> quote three",
            "\nline three"
        ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "line one")
        XCTAssertTrue(models[1] is IssueCommentQuoteModel)
        XCTAssertEqual((models[2] as! StyledTextRenderer).string.allText, "line two")
        XCTAssertTrue(models[3] is IssueCommentQuoteModel)
        XCTAssertEqual((models[4] as! StyledTextRenderer).string.allText, "line three")
    }

    func test_whenCheckmarks() {
        let body = [
            "- [ ] foo",
            "- [x] bar",
        ].joined(separator: "\r\n")
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        XCTAssertEqual(models.count, 1)

        let attrText = (models[0] as! StyledTextRenderer).string.render(contentSizeCategory: .large)
        XCTAssertNotNil(attrText.attributes(at: 2, effectiveRange: nil)[.attachment])
        XCTAssertNotNil(attrText.attributes(at: 11, effectiveRange: nil)[.attachment])
    }
    
    func test_linkContainingBrackets() {
        
        // Issue #120
        // the [\\[Pitch\\] slashes at one point rendered incorrectly as \[Pitch\] instead of [Pitch]
        
        let body = "...adoption.\r\n\r\nSee: [\\[Pitch\\] Introducing the \"Unwrap or Die\" operator to the standard library](https://lists.swift.org/pipermail/swift-evolution/Week-of-Mon-20170626/037730.html)"
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "...adoption.\nSee: [Pitch] Introducing the \"Unwrap or Die\" operator to the standard library")
    }
    
    func test_URLThatContainsIssueReferenceLinkInDescription() {
        
        // issue 1593: the issue reference link inside the link description was apparently the reason the link wasn't rendered correctly
        // the url was rendered as "[apple/swift-evolution#793](github.com/apple/swift-evolution/pull/793)"
        // instead of "apple/swift-evolution#793"
        
        let body = "This is the implementation for [apple/swift-evolution#793](https://github.com/apple/swift-evolution/pull/793)\r\n\r\nNote: One of the new tests fails..."
        
        let models = MarkdownModels(
            body,
            owner: "owner",
            repo: "repo",
            width: 0,
            viewerCanUpdate: false,
            contentSizeCategory: .large,
            isRoot: false
        )
        
        XCTAssertEqual((models[0] as! StyledTextRenderer).string.allText, "This is the implementation for apple/swift-evolution#793\nNote: One of the new tests fails...")        
    }

}
