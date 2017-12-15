//
//  StyledTextRendererSnapshotTests.swift
//  StyledTextTests
//
//  Created by Ryan Nystrom on 12/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
import Snap_swift
@testable import StyledText

extension UIView {

    func mount(width: CGFloat, renderer: StyledTextRenderer) -> UIView {
        frame = CGRect(origin: .zero, size: renderer.size(width: width))
        layer.contents = renderer.render(width: width).image
        return self
    }

}

class SnapTests: XCTestCase {

    let testScale: CGFloat = 2
    let lorem = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."

    override func setUp() {
        super.setUp()
//        isRecording = true
    }

    func test_lorem_100() {
        let builder = StyledTextBuilder(styledText: StyledText(text: lorem, style: TextStyle()))
        let renderer = StyledTextRenderer(builder: builder, backgroundColor: .white, scale: testScale)
        expect(UIView().mount(width: 100, renderer: renderer)).toMatchSnapshot()
    }

    func test_lorem_200() {
        let builder = StyledTextBuilder(styledText: StyledText(text: lorem, style: TextStyle()))
        let renderer = StyledTextRenderer(builder: builder, backgroundColor: .white, scale: testScale)
        expect(UIView().mount(width: 200, renderer: renderer)).toMatchSnapshot()
    }

    func test_lorem_300() {
        let builder = StyledTextBuilder(styledText: StyledText(text: lorem, style: TextStyle()))
        let renderer = StyledTextRenderer(builder: builder, backgroundColor: .white, scale: testScale)
        expect(UIView().mount(width: 300, renderer: renderer)).toMatchSnapshot()
    }

    func test_complexBuilder() {
        let builder = StyledTextBuilder(styledText: StyledText(text: "Hello, ", style: TextStyle()))
            .save()
            .add(text: "world!", traits: [.traitItalic, .traitBold])
            .restore()
            .add(text: " Pop back. ")
            .save()
            .add(styledText: StyledText(text: "Tiny text. ", style: TextStyle(size: 6)))
            .add(styledText: StyledText(text: "Big text. ", style: TextStyle(size: 20)))
            .restore()
            .add(text: "Background color.", traits: .traitBold, attributes: [.backgroundColor: UIColor.blue, .foregroundColor: UIColor.white])
        let renderer = StyledTextRenderer(builder: builder, backgroundColor: .white)
        expect(UIView().mount(width: 300, renderer: renderer)).toMatchSnapshot()
    }

}
