//
//  BookmarkStore.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol BookmarkListener: class {
    func didUpdateBookmarks()
}

class BookmarkStore: Store {

    typealias Model = Bookmark

    private class ListenerWrapper {
        weak var listener: BookmarkListener?

        init(listener: BookmarkListener) {
            self.listener = listener
        }
    }

    private var listeners: [ListenerWrapper] = []

    private let _key = "com.freetime.BookmarkStore.bookmark"
    var key: String {
        return token + _key
    }

    var values: [Bookmark]
    let defaults = UserDefaults.standard

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    let token: String

    init(token: String) {
        self.token = token
        guard let data = defaults.object(forKey: token + _key) as? Data,
            let array = try? decoder.decode([Bookmark].self, from: data) else {
            self.values = []
            return
        }
        self.values = array
    }

    func add(listener: BookmarkListener) {
        let wrapper = ListenerWrapper(listener: listener)
        listeners.append(wrapper)
    }

    func save() {
        guard let data = try? encoder.encode(values) else { return }
        defaults.set(data, forKey: key)
        listeners.forEach { $0.listener?.didUpdateBookmarks() }
    }

}
