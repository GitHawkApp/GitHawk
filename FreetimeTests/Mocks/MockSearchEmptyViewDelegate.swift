//
//  MockSearchEmptyViewDelegate.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import Freetime
class MockSearchEmptyViewDelegate: SearchEmptyViewDelegate {
    var didTap = false
    func didTap(emptyView: SearchEmptyView) {
        didTap = true
    }
}
