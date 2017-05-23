//
//  IssueTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class IssueTests: XCTestCase {

    func test_whenSearchingForImageURL_withOneImage() {
        let body = "foo ![alt](https://apple.com) bar"
        let result = imageURLMatches(body: body)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].range.location, 4)
        XCTAssertEqual(result[0].range.length, 25)
        XCTAssertEqual(result[0].numberOfRanges, 2)
        XCTAssertEqual(result[0].rangeAt(1).location, 11)
        XCTAssertEqual(result[0].rangeAt(1).length, 17)
    }

    func test_whenSearchingForImageURL_withOneImage_withNewlines() {
        let body = "foo\r\n![alt](https://apple.com)\r\nbar"
        let result = imageURLMatches(body: body)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].range.location, 5)
        XCTAssertEqual(result[0].range.length, 25)
        XCTAssertEqual(result[0].numberOfRanges, 2)
        XCTAssertEqual(result[0].rangeAt(1).location, 12)
        XCTAssertEqual(result[0].rangeAt(1).length, 17)
    }

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

    func test_whenPluckingImageURLSubstring_withNewlines() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text",
            ].joined(separator: "\r\n")
        let range = imageURLMatches(body: body)[0].rangeAt(1)
        let result = body.substring(with: range)
        XCTAssertEqual(result, "https://apple.com")
    }

    func test_whenImageInTheMiddle() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text",
            ].joined(separator: "\r\n")
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "then some more text")
    }

    func test_whenStringHasNewlines() {
        let body = "foo\r\nbar"
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 1)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "foo\nbar")
    }

    func test_whenImageAtTheBeginning() {
        let body = [
            "![alt text](https://apple.com)",
            "this is the first line",
            "then some more text",
            ].joined(separator: "\r\n")
        let models = createCommentModels(body: body, width: 300)
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
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 2)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line\nthen some more text")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
    }

    func test_whenOnlyOneImage() {
        let body = [
            "![alt text](https://apple.com)",
            ].joined(separator: "\r\n")
        let models = createCommentModels(body: body, width: 300)
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
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "then some more text")
        XCTAssertEqual((models[3] as! IssueCommentImageModel).url.absoluteString, "https://google.com")
        XCTAssertEqual((models[4] as! NSAttributedStringSizing).attributedText.string, "foo bar baz")
    }

    func test_whenCodeBlock_withSurroundedByText() {
        let body = [
            "this is some text",
            "```swift",
            "let a = 5",
            "```",
            "this is the end"
        ].joined(separator: "\r\n")
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is some text")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).code.attributedText.string, "let a = 5")
        XCTAssertEqual((models[1] as! IssueCommentCodeBlockModel).language, "swift")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "this is the end")
    }
    
}
