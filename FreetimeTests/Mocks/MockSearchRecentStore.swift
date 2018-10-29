//
//  MockSearchRecentStore.swift
//  FreetimeTests
//
//  Created by Hesham Salman on 10/29/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

@testable import Freetime
class MockSearchRecentStore: SearchRecentStore {
    var mockValues: [SearchQuery] = []

    override var values: [SearchQuery] {
        set { mockValues = newValue }
        get { return mockValues }
    }

    init() {
        super.init(key: "wow.real.searchresults")
    }
}
