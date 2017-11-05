//
//  BookmarkStore.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

class BookmarkStore: Store {

    typealias Model = Bookmark

    let key: String = "com.freetime.BookmarkStore.bookmark"

    var values: [Bookmark] {
        get {
            guard let data = defaults.object(forKey: key) as? Data,
                let array = try? decoder.decode([Bookmark].self, from: data) else {
                    return []
            }
            return array
        }

        set {
            guard let data = try? encoder.encode(newValue) else { return }
            defaults.set(data, forKey: key)
        }
    }
    let defaults = UserDefaults.standard

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    let token: String

    init(token: String) {
        self.token = token
    }

}
