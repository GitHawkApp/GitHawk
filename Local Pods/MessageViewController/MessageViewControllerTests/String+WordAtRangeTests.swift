//
//  String+WordAtRangeTests.swift
//  MessageViewControllerTests
//
//  Created by Ryan Nystrom on 12/27/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
import MessageViewController

class String_WordAtRangeTests: XCTestCase {
    
    func test_wordParts_whenSingleCharacter() {
        // 16 characters
        let text = "foo bar\nbaz bang"

        let begin = text.wordParts(text.index(text.startIndex, offsetBy: 0) ..< text.index(text.startIndex, offsetBy: 0))
        XCTAssertEqual(begin?.left, "")
        XCTAssertEqual(begin?.right, "foo")

        let middle = text.wordParts(text.index(text.startIndex, offsetBy: 5) ..< text.index(text.startIndex, offsetBy: 5))
        XCTAssertEqual(middle?.left, "b")
        XCTAssertEqual(middle?.right, "ar")

        let newline = text.wordParts(text.index(text.startIndex, offsetBy: 10) ..< text.index(text.startIndex, offsetBy: 10))
        XCTAssertEqual(newline?.left, "ba")
        XCTAssertEqual(newline?.right, "z")

        let end = text.wordParts(text.index(text.startIndex, offsetBy: 16) ..< text.index(text.startIndex, offsetBy: 16))
        XCTAssertEqual(end?.left, "bang")
        XCTAssertEqual(end?.right, "")
    }

    func test_wordParts_whenMultipleCharacters() {
        // 16 characters
        let text = "foo bar\nbaz bang"

        let begin = text.wordParts(text.index(text.startIndex, offsetBy: 0) ..< text.index(text.startIndex, offsetBy: 1))
        XCTAssertEqual(begin?.left, "f")
        XCTAssertEqual(begin?.right, "oo")

        let middle = text.wordParts(text.index(text.startIndex, offsetBy: 0) ..< text.index(text.startIndex, offsetBy: 5))
        XCTAssertEqual(middle?.left, "b")
        XCTAssertEqual(middle?.right, "ar")

        let newline = text.wordParts(text.index(text.startIndex, offsetBy: 6) ..< text.index(text.startIndex, offsetBy: 10))
        XCTAssertEqual(newline?.left, "ba")
        XCTAssertEqual(newline?.right, "z")

        let end = text.wordParts(text.index(text.startIndex, offsetBy: 15) ..< text.index(text.startIndex, offsetBy: 16))
        XCTAssertEqual(end?.left, "bang")
        XCTAssertEqual(end?.right, "")
    }

    func test_word_whenEmpty() {
        XCTAssertNil("".word(at: NSRange(location: 0, length: 0)))
    }

    func test_word_whenWhitespace() {
        XCTAssertNil(" ".word(at: NSRange(location: 0, length: 0)))
    }

    func test_word_whenNewline() {
        XCTAssertNil("\n".word(at: NSRange(location: 0, length: 0)))
    }

    func test_word_whenLeftCharacterWhitespace_thatUsesRightmostWord() {
        let text = "foo bar\nbaz bang"

        let result = text.word(at: NSRange(location: 4, length: 0))
        XCTAssertEqual(result?.word, "bar")
        XCTAssertEqual(text[result!.range], "bar")
    }

    func test_word_whenLeftCharacterWhitespace_withRangeIncludingWords_thatUsesRightmostWord() {
        let text = "foo bar\nbaz bang"

        let result = text.word(at: NSRange(location: 4, length: 4))
        XCTAssertEqual(result?.word, "baz")
        XCTAssertEqual(text[result!.range], "baz")
    }

    func test_word_whenRangeWithinWord() {
        let text = "foo bar\nbaz bang"
        let result = text.word(at: NSRange(location: 5, length: 1))
        XCTAssertEqual(result?.word, "bar")
        XCTAssertEqual(text[result!.range], "bar")
    }
    
}
