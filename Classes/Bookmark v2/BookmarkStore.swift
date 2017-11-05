//
//  BookmarkStore.swift
//  Freetime
//
//  Created by Hesham Salman on 11/5/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

struct BookmarkStore: Store {

    typealias Model = Bookmark

    let key: String = "com.freetime.BookmarkStore.bookmark"

    var values: [Bookmark]
    let defaults = UserDefaults.standard

    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    init() {
        guard let data = defaults.object(forKey: key) as? Data,
            let array = try? decoder.decode([Bookmark].self, from: data) else {
            values = []
            return
        }
        values = array
    }

}
