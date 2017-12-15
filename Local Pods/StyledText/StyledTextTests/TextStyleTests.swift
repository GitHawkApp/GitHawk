//
//  TextStyleTests.swift
//  StyledTextTests
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import StyledText

class TextStyleTests: XCTestCase {
    
    func test_initializersPassed() {
        let style = TextStyle(
            name: "name",
            size: 12,
            attributes: [.foregroundColor: UIColor.white],
            traits: [.traitItalic, .traitBold],
            minSize: 11,
            maxSize: 13
        )
        XCTAssertEqual(style.name, "name")
        XCTAssertEqual(style.size, 12)
        XCTAssertEqual(style.attributes[.foregroundColor] as! UIColor, UIColor.white)
        XCTAssertEqual(style.traits, [UIFontDescriptorSymbolicTraits.traitItalic, UIFontDescriptorSymbolicTraits.traitBold])
        XCTAssertEqual(style.minSize, 11)
        XCTAssertEqual(style.maxSize, 13)
    }

    func test_whenObjectsSame_thatHashHits() {
        XCTAssertEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue,
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue
        )
    }

    func test_whenNameDiffers_thatHashMisses() {
        XCTAssertNotEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue,
            TextStyle(
                name: "foo",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue
        )
    }

    func test_whenSizeDiffers_thatHashMisses() {
        XCTAssertNotEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue,
            TextStyle(
                name: "name",
                size: 13,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue
        )
    }

    func test_whenAttributeCountsDiffer_thatHashMisses() {
        XCTAssertNotEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue,
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white, .backgroundColor: UIColor.black],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue
        )
    }

    func test_whenAttributesDiffer_thatNotEqual() {
        XCTAssertNotEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ),
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.black],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                )
        )
    }

    func test_whenTraitsDiffer_thatHashMisses() {
        XCTAssertNotEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue,
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic],
                minSize: 11,
                maxSize: 13
                ).hashValue
        )
    }

    func test_whenMinSizeDiffers_thatHashMisses() {
        XCTAssertNotEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue,
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 12,
                maxSize: 13
                ).hashValue
        )
    }

    func test_whenMaxSizeDiffers_thatHashMisses() {
        XCTAssertNotEqual(
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 13
                ).hashValue,
            TextStyle(
                name: "name",
                size: 12,
                attributes: [.foregroundColor: UIColor.white],
                traits: [.traitItalic, .traitBold],
                minSize: 11,
                maxSize: 14
                ).hashValue
        )
    }
    
}
