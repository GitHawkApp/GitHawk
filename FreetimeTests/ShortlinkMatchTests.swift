//
//  ShortlinkMatchTests.swift
//  FreetimeTests
//
//  Created by B_Litwin on 7/22/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime
import StyledTextKit

class ShortlinkRegExTests: XCTestCase {
    // Test the String method detectAndHandleShortlink()

    func setupBuilder(with text: String) -> StyledTextString {
        let builder = StyledTextBuilder(text: "")
        text.detectAndHandleShortlink(
            owner: "rnystrom",
            repo: "GitHawk",
            builder: builder
        )
        return builder.build()
    }
    
    func checkForIssueLink(_ styledTexts: [StyledText]) -> Bool {
        // scanning for a styledText unit that has been formatted with blue font and
        // contains an Issue MarkdownAttribute
        for style in styledTexts.map({ $0.style }) {
            guard style.attributes[.foregroundColor] != nil,
                style.attributes[MarkdownAttribute.issue] != nil else { continue }
            let correctTextColor = style.attributes[.foregroundColor] as! UIColor == Styles.Colors.Blue.medium.color
            if correctTextColor { return true }
        }
        
        return false
    }
    
    func test_positiveMatches() {
        var builder: StyledTextString = setupBuilder(with: "#1234")
        var containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertTrue(containsLink)
        
        builder = setupBuilder(with: "with a space preceding #1234")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertTrue(containsLink)
        
        builder = setupBuilder(with: "with a newline preceding \n#1234")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertTrue(containsLink)
        
        builder = setupBuilder(with: "embedded in parentheses (#1234)")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertTrue(containsLink)
        
        builder = setupBuilder(with: "with owner and repo preceding rnystrom/githawk#1234")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertTrue(containsLink)
    }
    
    func test_negativeMatches() {
        var builder = setupBuilder(with: "!1234")
        var containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertFalse(containsLink)
        
        builder = setupBuilder(with: "imo the best pr so far is prob # 1906")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertFalse(containsLink)
        
        builder = setupBuilder(with: "#123T")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertFalse(containsLink)
        
        builder = setupBuilder(with: "Fixes#1234")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertFalse(containsLink)
        
        builder = setupBuilder(with: "Fixes(#1234)")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertFalse(containsLink)
        
        builder = setupBuilder(with: "Fixes (#1234")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertFalse(containsLink)
        
        builder = setupBuilder(with: "Fixes #1234)")
        containsLink = checkForIssueLink(builder.styledTexts)
        XCTAssertFalse(containsLink)
    }
}
