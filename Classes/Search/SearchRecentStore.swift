//
//  SearchRecentStore.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

class SearchRecentStore: Store {

    typealias Model = SearchQuery

    let key = "com.freetime.SearchRecentStore.results"

    let defaults = UserDefaults.standard
    var values: [SearchQuery]
    var listeners: [ListenerWrapper] = []

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init() {
        if let data = defaults.object(forKey: key) as? Data,
            let array = try? decoder.decode([SearchQuery].self, from: data) {
            values = array
        } else {
            values = []
        }
    }

    // MARK: Public API

    func add(_ value: SearchQuery) {
        remove(value)
        values.insert(value, at: 0)

        // keep recents trimmed
        while values.count > 15 {
            values.removeLast()
        }

        save()
    }

}
