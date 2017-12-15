//
//  StyledTextTests.swift
//  StyledTextTests
//
//  Created by Ryan Nystrom on 12/12/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import StyledText

class StyledTextTests: XCTestCase {
    
    func test_renderingStyledtextToAttributedString() {
        let name = UIFont.systemFont(ofSize: 1).fontName
        let style = TextStyle(
            name: name,
            size: 12,
            attributes: [.foregroundColor: UIColor.white],
            traits: [.traitBold, .traitItalic]
        )
        let text = StyledText(text: "foo", style: style)
        let render = text.render(contentSizeCategory: .large)
        XCTAssertEqual(render.string, "foo")

        let attributes = render.attributes(at: 1, effectiveRange: nil)
        XCTAssertEqual(attributes[.foregroundColor] as! UIColor, UIColor.white)

        let font = attributes[.font] as! UIFont
        XCTAssertEqual(font.familyName, UIFont.systemFont(ofSize: 1).familyName)
        XCTAssertEqual(font.fontDescriptor.symbolicTraits, [.traitItalic, .traitBold])
        XCTAssertEqual(font.pointSize, 12)
    }
    
}
