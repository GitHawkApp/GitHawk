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

    init() {
        if let arr = defaults.object(forKey: Keys.results) as? [String] {
            _recents = NSMutableOrderedSet(array: arr)
        } else {
            _recents = NSMutableOrderedSet()
        }
    }

    // MARK: Public API

    func add(recent: String) {
        _recents.remove(recent)
        _recents.insert(recent, at: 0)

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

    var recents: [String] {
        return _recents.array as? [String] ?? []
    }

    func removeLast() {
        guard !recents.isEmpty else { return }
        _recents.removeObject(at: _recents.count - 1)
        save()
    }

    // MARK: Private API

    func save() {
        defaults.set(_recents.array, forKey: Keys.results)
    }

}
