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

    func test_withNonStrings() {
        let builder = URLBuilder(host: "github.com")
            .add(path: 42)
            .add(path: 0.0)
        XCTAssertEqual(builder.url!.absoluteString, "https://github.com/42/0.0")
    }

    func test_withItems() {
        // URL(string: "https://github.com/login/oauth/authorize?client_id=\(Secrets.GitHub.clientId)&scope=user+repo+notifications")!
        let builder = URLBuilder.github()
            .add(paths: ["login", "oauth", "authorize"])
            .add(item: "client_id", value: 1234)
            .add(item: "scope", value: "user+repo+notifications")
        XCTAssertEqual(
            builder.url!.absoluteString,
            "https://github.com/login/oauth/authorize?client_id=1234&scope=user+repo+notifications"
        )
    }

}
