//
//  FilePathTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 12/3/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class FilePathTests: XCTestCase {

    func test_initWithNoComponents() {
        let filePath = FilePath(components: [])
        XCTAssertEqual(filePath.path, "")
        XCTAssertNil(filePath.current)
        XCTAssertNil(filePath.fileExtension)
        XCTAssertNil(filePath.basePath)
    }

    func test_withOneComponent() {
        let filePath = FilePath(components: ["baz.swift"])
        XCTAssertEqual(filePath.path, "baz.swift")
        XCTAssertEqual(filePath.current, "baz.swift")
        XCTAssertEqual(filePath.fileExtension, "swift")
        XCTAssertNil(filePath.basePath)
    }

    func test_withTwoComponents() {
        let filePath = FilePath(components: ["foo", "baz.swift"])
        XCTAssertEqual(filePath.path, "foo/baz.swift")
        XCTAssertEqual(filePath.current, "baz.swift")
        XCTAssertEqual(filePath.fileExtension, "swift")
        XCTAssertEqual(filePath.basePath, "foo")
    }

    func test_withThreeComponents() {
        let filePath = FilePath(components: ["foo", "bar", "baz.swift"])
        XCTAssertEqual(filePath.path, "foo/bar/baz.swift")
        XCTAssertEqual(filePath.current, "baz.swift")
        XCTAssertEqual(filePath.fileExtension, "swift")
        XCTAssertEqual(filePath.basePath, "foo/bar")
    }

    func test_appending() {
        XCTAssertEqual(FilePath(components: []).appending("baz.swift").path, "baz.swift")
        XCTAssertEqual(FilePath(components: ["foo"]).appending("baz.swift").path, "foo/baz.swift")
        XCTAssertEqual(FilePath(components: ["foo", "bar"]).appending("baz.swift").path, "foo/bar/baz.swift")
        XCTAssertEqual(FilePath(components: ["foo", "bar", "bang"]).appending("baz.swift").path, "foo/bar/bang/baz.swift")
    }
    
}
