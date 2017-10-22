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
    private var _recents: [SearchQuery]

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init() {
        if let data = defaults.object(forKey: Keys.results) as? Data,
            let array = try? decoder.decode([SearchQuery].self, from: data) {
            _recents = array
        } else {
            _recents = []
        }
    }

    // MARK: Public API

    func add(query: SearchQuery) {
        remove(query: query)
        _recents.insert(query, at: 0)

        // keep recents trimmed
        while _recents.count > 15 {
            _recents.removeLast()
        }

        save()
    }

    func remove(query: SearchQuery) {
        guard let offset = _recents.index(of: query) else { return }
        let index = _recents.startIndex.distance(to: offset)
        _recents.remove(at: index)
        save()
    }

    func clear() {
        _recents.removeAll()
        save()
    }

    var recents: [SearchQuery] {
        return _recents
    }

    func removeLast() {
        guard !recents.isEmpty else { return }
        _recents.removeLast()
        save()
    }

    // MARK: Private API

    func save() {
        guard let data = try? encoder.encode(recents) else { return }
        defaults.set(data, forKey: Keys.results)
    }

}
