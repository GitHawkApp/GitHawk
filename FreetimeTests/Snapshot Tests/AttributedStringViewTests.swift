//
//  AttributedStringViewTests.swift
//  FreetimeTests
//
//  Created by Austinate on 10/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest
import FBSnapshotTestCase
@testable import Freetime

class AttributedStringViewTests: FBSnapshotTestCase {
    let initialFrame = CGRect(origin: .zero, size: CGSize(width: 320, height: 44))
    var view: AttributedStringView!

    override func setUp() {
        super.setUp()
        view = AttributedStringView(frame: initialFrame)
    }

    func testAttributedStringUIWithSimpleTextIsCorrect() {
        let attributed = NSAttributedString(string: "This is just a sample\nof simple\ntext")
        let text = NSAttributedStringSizing(containerWidth: initialFrame.width,
                                            attributedText: attributed)
        view.configureAndSizeToFit(text: text, width: initialFrame.width)
        FBSnapshotVerifyView(view)
    }

    func testAttributedStringUIEmailIsCorrect() {
        let attributes: [NSAttributedStringKey: Any] = [.foregroundColor: UIColor.gray]
        let attributedTitle = NSMutableAttributedString(string: "This is sample title with\n email: ",
                                                        attributes: attributes)
        let email = NSAttributedString(string: "test@email.com",
                                       attributes: [MarkdownAttribute.email: "test@email.com"])
        attributedTitle.append(email)
        let text = NSAttributedStringSizing(containerWidth: initialFrame.width,
                                             attributedText: attributedTitle)
        view.configureAndSizeToFit(text: text, width: initialFrame.width)
        FBSnapshotVerifyView(view)
    }
}
