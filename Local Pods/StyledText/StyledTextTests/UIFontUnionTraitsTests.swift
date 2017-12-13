//
//  UIFontUnionTraitsTests.swift
//  StyledTextTests
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import StyledText

class UIFontUnionTraitsTests: XCTestCase {
    
    func test_whenAddingNewTraits_thatNewFontHasTraits() {
        let font = UIFont.systemFont(ofSize: 12)
        let newFont = font.addingTraits(traits: .traitBold)
        XCTAssertTrue(newFont.fontDescriptor.symbolicTraits.contains(.traitBold))
    }

    func test_whenAddingEmptyTraits_thatNewFontEqual() {
        let font = UIFont.systemFont(ofSize: 12)
        let newFont = font.addingTraits(traits: [])
        XCTAssertEqual(font, newFont)
    }

    func test_whenAddingSameTraits_thatNewFontEqual() {
        let font = UIFont.systemFont(ofSize: 12).addingTraits(traits: .traitBold)
        let newFont = font.addingTraits(traits: .traitBold)
        XCTAssertEqual(font, newFont)
    }

    func test_whenAddingMultipleTraits_thatBothAreInNewFont() {
        let font = UIFont.systemFont(ofSize: 12)
        let newFont = font.addingTraits(traits: [.traitBold
            , .traitItalic])
        XCTAssertTrue(newFont.fontDescriptor.symbolicTraits.contains(.traitBold))
        XCTAssertTrue(newFont.fontDescriptor.symbolicTraits.contains(.traitItalic))
    }
    
}
