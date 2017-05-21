//
//  IssueTests.swift
//  Freetime
//
//  Created by Ryan Nystrom on 5/21/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class IssueTests: XCTestCase {

    func test_whenImageInTheMiddle() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text",
            ].joined(separator: "\\r\\n")
        let models = createCommentModels(body: body, width: 300)
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
            ].joined(separator: "\\r\\n")
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[1] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "then some more text")
    }

    func test_whenImageAtTheEnd() {
        let body = [
            "this is the first line",
            "then some more text",
            "![alt text](https://apple.com)",
            ].joined(separator: "\\r\\n")
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 3)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[1] as! NSAttributedStringSizing).attributedText.string, "then some more text")
        XCTAssertEqual((models[2] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
    }

    func test_whenOnlyOneImage() {
        let body = [
            "![alt text](https://apple.com)",
            ].joined(separator: "\\r\\n")
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 1)
        XCTAssertEqual((models[0] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
    }

    func test_whenMultipleImagesSurroundedByText() {
        let body = [
            "this is the first line",
            "![alt text](https://apple.com)",
            "then some more text",
            "![alt text](https://google.com)",
            "foo bar baz",
            ].joined(separator: "\\r\\n")
        let models = createCommentModels(body: body, width: 300)
        XCTAssertEqual(models.count, 5)
        XCTAssertEqual((models[0] as! NSAttributedStringSizing).attributedText.string, "this is the first line")
        XCTAssertEqual((models[1] as! IssueCommentImageModel).url.absoluteString, "https://apple.com")
        XCTAssertEqual((models[2] as! NSAttributedStringSizing).attributedText.string, "then some more text")
        XCTAssertEqual((models[3] as! IssueCommentImageModel).url.absoluteString, "https://google.com")
        XCTAssertEqual((models[4] as! NSAttributedStringSizing).attributedText.string, "foo bar baz")
    }
    
}
