//
//  StyledTextBuilderTests.swift
//  StyledTextTests
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import StyledText

class StyledTextBuilderTests: XCTestCase {
    
    func test_whenOneLevel() {
        let render = StyledTextBuilder(styledText: StyledText(text: "foo"))
            .render(contentSizeCategory: .large)
        XCTAssertEqual(render.string, "foo")
    }

    func test_whenAddingString() {
        let render = StyledTextBuilder(styledText: StyledText(text: "foo"))
            .add(text: " bar")
            .render(contentSizeCategory: .large)
        XCTAssertEqual(render.string, "foo bar")
    }

    func test_whenAddingAttributes() {
        let render = StyledTextBuilder(styledText: StyledText(text: "foo", style: TextStyle(traits: .traitBold)))
            .add(styledText: StyledText(text: " bar", style: TextStyle(traits: .traitItalic)))
            .render(contentSizeCategory: .large)
        XCTAssertEqual(render.string, "foo bar")

        let font1 = render.attributes(at: 1, effectiveRange: nil)[.font] as! UIFont
        XCTAssertEqual(font1.fontDescriptor.symbolicTraits, .traitBold)

        let font2 = render.attributes(at: 5, effectiveRange: nil)[.font] as! UIFont
        XCTAssertEqual(font2.fontDescriptor.symbolicTraits, .traitItalic)
    }

    func test_whenAddingAttributes_withSavingState_thenRestoring() {
        let render = StyledTextBuilder(styledText: StyledText(text: "foo", style: TextStyle(traits: .traitBold)))
            .save()
            .add(styledText: StyledText(text: " bar", style: TextStyle(traits: .traitItalic)))
            .restore()
            .add(text: " baz")
            .render(contentSizeCategory: .large)
        XCTAssertEqual(render.string, "foo bar baz")

        let font1 = render.attributes(at: 1, effectiveRange: nil)[.font] as! UIFont
        XCTAssertEqual(font1.fontDescriptor.symbolicTraits, .traitBold)

        let font2 = render.attributes(at: 5, effectiveRange: nil)[.font] as! UIFont
        XCTAssertEqual(font2.fontDescriptor.symbolicTraits, .traitItalic)

        let font3 = render.attributes(at: 9, effectiveRange: nil)[.font] as! UIFont
        XCTAssertEqual(font3.fontDescriptor.symbolicTraits, .traitBold)
    }
    
}
