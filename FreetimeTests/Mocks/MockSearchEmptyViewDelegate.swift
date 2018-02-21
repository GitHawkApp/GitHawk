//
//  MockInitialEmptyViewDelegate.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/18/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation
import XCTest

@testable import GitHawk
class MockInitialEmptyViewDelegate: InitialEmptyViewDelegate {
    var didTap = false
    func didTap(emptyView: InitialEmptyView) {
        didTap = true
    }
}
