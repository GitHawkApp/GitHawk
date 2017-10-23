//
//  IssueTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
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
            "then some more text",
            ].joined(separator: "\r\n")
        let result = body.substring(with: NSRange(location: 36, length: 17))
        XCTAssertEqual(result, "https://apple.com")
    }

    func test_whenImageInTheMiddle() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text",
            ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "then some more text")
    }

    func test_whenImageAtTheBeginning() {
        let body = [
            "![alt text](https://apple.com)",
            "this is the first line",
            "then some more text",
            ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 2)
        XCTAssertEqual((models[0] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[1] as! NSAttributedStringSizing).attributedText.string, "this is the first line\nthen some more text")
    }

    func test_whenImageAtTheEnd() {
        let body = [
            "this is the first line",
            "then some more text",
            "![alt text](https://apple.com)",
            ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 2)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line\nthen some more text")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
    }

    func test_whenOnlyOneImage() {
        let body = [
            "![alt text](https://apple.com)",
            ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 1)
        XCTAssertEqual((models[0] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
    }

    func test_whenMultipleImages_withSurroundedByText() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text",
            "![alt text](https://google.com)",
            "foo bar baz",
            ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "then some more text")
        XCTAssertEqual((models[3] as! IssueCommentImageModel).url.absoluteString, "https://google.com")
        XCTAssertEqual((models[4] as! NSAttributedStringSizing).attributedText.string, "foo bar baz")
    }

    func test_whenCodeBlock_withLanguage_withSurroundedByText() {
        let body = [
            "this is some text",
            "```swift",
            "let a = 5",
            "```",
            "this is the end"
        ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is some text")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).code.attributedText.string, "let a = 5")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).language, "swift")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "this is the end")
    }

    func test_whenCodeBlock_withoutLanguage_withSurroundedByText() {
        let body = [
            "this is some text",
            "```",
            "let a = 5",
            "```",
            "this is the end"
            ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is some text")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).code.attributedText.string, "let a = 5")
        XCTAssertNil((models[1] as! IssueCommentCodeBlockModel).language)
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "this is the end")
    }

    func test_whenImageEmbeddedInCode() {
        let body = [
            "this is the first line",
            "```lang",
            "![alt text](https://apple.com)",
            "```",
            "then some more text",
            "![alt text](https://google.com)",
            "foo bar baz",
            ].joined(separator: "\r\n")
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).language, "lang")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "then some more text")
        XCTAssertEqual((models[3] as! IssueCommentImageModel).url.absoluteString, "https://google.com")
        XCTAssertEqual((models[4] as! NSAttributedStringSizing).attributedText.string, "foo bar baz")
    }

    func test_whenCodePartOfParagraph() {
        let body = "text with ````` inline with ````` more"
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
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
        let options = GitHubMarkdownOptions(owner: "owner", repo: "repo", flavors: [])
        let models = CreateCommentModels(markdown: body, width: 300, options: options)
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "line one")
        XCTAssertTrue(models[1] is IssueCommentQuoteModel)
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "line two")
        XCTAssertTrue(models[3] is IssueCommentQuoteModel)
        XCTAssertEqual((models[4] as! NSAttributedStringSizing).attributedText.string, "line three")
    }
    
}
