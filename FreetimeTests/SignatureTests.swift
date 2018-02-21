//
//  SignatureTests.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import Freetime
class SignatureTests: XCTestCase {

    func test_enabled_customSetter() {
        let key = "com.freetime.Signature.enabled"
        UserDefaults.standard.set(false, forKey: key)
        XCTAssertFalse(Signature.enabled)
    }

    func test_signed_enabledSignature() {
        Signature.enabled = true

        let text = "Hello, world!"
        let format = NSLocalizedString("Sent with %@", comment: "")
        let signature = String.localizedStringWithFormat(format, "<a href=\"http://githawk.com\">GitHawk</a>")

        let expected = text + "\n\n<sub>\(signature)</sub>"
        let actual = Signature.signed(text: text)

        XCTAssertEqual(expected, actual)
    }

    func test_signed_disabledSignature() {
        Signature.enabled = false

        let text = "Hello, world!"

        let expected = text
        let actual = Signature.signed(text: text)

        XCTAssertEqual(expected, actual)
    }

}
