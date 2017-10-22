//
//  IssueLabelCellTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import Freetime
class IssueLabelCellTests: XCTestCase {

    var issueLabelCell: IssueLabelCell!

    override func setUp() {
        super.setUp()
        let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40.0)
        issueLabelCell = IssueLabelCell(frame: frame)
    }

    func test_background_styling() {
        let expectedCornerRadius = Styles.Sizes.avatarCornerRadius
        let actualCornerRadius = issueLabelCell.background.layer.cornerRadius

        XCTAssertEqual(expectedCornerRadius, actualCornerRadius)

        XCTAssertTrue(issueLabelCell.background.subviews.contains(issueLabelCell.label))
    }

    func test_label_styling() {
        let expectedFont = Styles.Fonts.smallTitle
        let actualFont = issueLabelCell.label.font

        XCTAssertEqual(expectedFont, actualFont)
    }

    func test_bindViewModel_repsitoryLabelViewModel() {
        let viewModel = RepositoryLabel(color: "#FF0000", name: "Hello, world!")
        issueLabelCell.bindViewModel(viewModel)

        let expectedBackgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
        let actualBackgroundColor = issueLabelCell.background.backgroundColor

        XCTAssertEqual(expectedBackgroundColor, actualBackgroundColor)

        let expectedText = "Hello, world!"
        let actualText = issueLabelCell.label.text

        XCTAssertEqual(expectedText, actualText)

        let expectedTextColor = expectedBackgroundColor.textOverlayColor
        let actualTextColor = issueLabelCell.label.textColor

        XCTAssertEqual(expectedTextColor, actualTextColor)
    }

    func test_bindViewModel_invalidViewModel() {
        let defaultLabel = UILabel()
        issueLabelCell.bindViewModel("")

        XCTAssertNil(issueLabelCell.label.text)
        XCTAssertEqual(defaultLabel.textColor, issueLabelCell.label.textColor)
    }
}
