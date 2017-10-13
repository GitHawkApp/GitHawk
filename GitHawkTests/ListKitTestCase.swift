//
//  ListKitTestCase.swift
//  GitHawk
//
//  Created by Ryan Nystrom on 5/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import XCTest

class ListKitTestCase: XCTestCase {

    let kit = ListTestKit()

    override func setUp() {
        super.setUp()
        kit.setup()
    }

}
