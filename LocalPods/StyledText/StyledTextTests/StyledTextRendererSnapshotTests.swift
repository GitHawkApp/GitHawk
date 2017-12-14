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

class SnapTests: XCTestCase {

    override func setUp() {
        super.setUp()
        isRecording = true
    }

    func test_() {
        let builder = StyledTextBuilder(styledText: StyledText(text: "Hello, ", style: TextStyle()))
            .add(text: "world!", traits: [.traitBold, .traitItalic])
        let renderer = StyledTextRenderer(builder: builder)
        let view = UIView()
        let width: CGFloat = 100
        view.frame = CGRect(origin: .zero, size: renderer.size(width: width))
        view.layer.contents = renderer.render(width: width)

        expect(view).toMatchSnapshot()
    }

}
