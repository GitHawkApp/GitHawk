//
//  SearchRecentStore.swift
//  Freetime
//
//  Created by Ryan Nystrom on 9/4/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class SearchRecentStore {

    private enum Keys {
        static let results = "com.freetime.SearchRecentStore.results"
    }

    private let defaults = UserDefaults.standard
    private var _recents: NSMutableOrderedSet

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        if let data = defaults.object(forKey: Keys.results) as? Data,
            let array = try? decoder.decode([SearchQuery].self, from: data) {
            _recents = NSMutableOrderedSet(array: array)
        } else {
            _recents = NSMutableOrderedSet()
        }
    }

    // MARK: Public API

    func add(query: SearchQuery) {
        _recents.remove(query)
        _recents.insert(query, at: 0)

        // keep recents trimmed
        while _recents.count > 15 {
            _recents.removeObject(at: _recents.count - 1)
        }

        save()
    }

    func remove(recent: String) {
        _recents.remove(recent)
        save()
    }

    func clear() {
        _recents.removeAllObjects()
        save()
    }

    var recents: [SearchQuery] {
        return _recents.array as? [SearchQuery] ?? []
    }

    func removeLast() {
        guard !recents.isEmpty else { return }
        _recents.removeObject(at: _recents.count - 1)
        save()
    }

    // MARK: Private API

    func save() {
        guard let data = try? encoder.encode(recents) else {
            return
        }
        defaults.set(data, forKey: Keys.results)
    }

}
