//
//  BookmarkCloudMigratorTests.swift
//  FreetimeTests
//
//  Created by Ryan Nystrom on 11/24/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import XCTest
@testable import Freetime

class BookmarkCloudMigratorTests: XCTestCase {

    override func setUp() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
    }



}
