//
//  ReplyCommentTests.swift
//  FreetimeTests
//
//  Created by Joan Disho on 09.05.18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest

class ReplyCommentTests: XCTestCase {

    let textWithNewLines = "Couldn't find an open ticket for this, close if there is though!\n\n" +
    "In conjuction with apps like working copy it would be super helpful to open merge requests!\n\n" +
    "<details>\n" +
    "<summary>Bug Report Dump (Auto-generated)</summary>\n" +
    "<pre>\n" +
    "Version 1.20.0 (1525621207)\n" +
    "Device: iPhone 6s Plus (iOS 11.4)\n" +
    "TestFlight: true\n" +
    "</pre>\n" +
    "</details>"

    let anotherTexttWithLessLines = "Couldn't find an open ticket for this, close if there is though!" +
        "In conjuction with apps like working copy it would be super helpful to open merge requests!\n\n"

    let emptyText = ""

    func test_substringUntilNewLine() {
        XCTAssertEqual(
            textWithNewLines.substringUntilNewLine(),
            "Couldn't find an open ticket for this, close if there is though! ...")

        XCTAssertEqual(
            anotherTexttWithLessLines.substringUntilNewLine(),
            "Couldn't find an open ticket for this, close if there is though!In conjuction with apps like working copy it would be super helpful to open merge requests! ...")

        XCTAssertEqual(emptyText.substringUntilNewLine(),"")
    }


    
}
