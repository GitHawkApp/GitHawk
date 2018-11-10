//
//  URLBuilderTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/10/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class URLBuilderTests: XCTestCase {

    func test_basicURL() {
        let builder = URLBuilder(host: "github.com")
        XCTAssertEqual(builder.url!.absoluteString, "https://github.com")
    }

    func test_basicURL_withHTTP() {
        let builder = URLBuilder(host: "github.com", https: false)
        XCTAssertEqual(builder.url!.absoluteString, "http://github.com")
    }

    func test_withOnePath() {
        let builder = URLBuilder(host: "github.com").add(path: "user")
        XCTAssertEqual(builder.url!.absoluteString, "https://github.com/user")
    }

    func test_withTwoPaths() {
        let builder = URLBuilder(host: "github.com")
            .add(path: "user")
            .add(path: "rnystrom")
        XCTAssertEqual(builder.url!.absoluteString, "https://github.com/user/rnystrom")
    }

    func test_withSpaceInPath() {
        let builder = URLBuilder(host: "github.com")
            .add(path: "githawkapp")
            .add(path: "githawk")
            .add(path: "blob")
            .add(path: "master")
            .add(path: "Classes")
            .add(path: "Image Upload")
            .add(path: "ImageUpload.storyboard")
        XCTAssertEqual(
            builder.url!.absoluteString,
            "https://github.com/githawkapp/githawk/blob/master/Classes/Image%20Upload/ImageUpload.storyboard"
        )
    }

}
