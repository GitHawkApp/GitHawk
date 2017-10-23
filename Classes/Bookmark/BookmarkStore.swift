//
//  BookmarkStore.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class BookmarksStore {
    static let shared = BookmarksStore()

    private let archivePath: String = {
        return FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            // crash intentionally on startup if doesn't exist
            .first!
            .appendingPathComponent("bookmarks")
            .path
    }()
    private var _bookmarks: Set<BookmarkModel>

    // MARK: Init

    init() {
        if let bookmarks = NSKeyedUnarchiver.unarchiveObject(withFile: archivePath) as? Set<BookmarkModel> {
            _bookmarks = bookmarks
        } else {
            _bookmarks = []
        }
    }

    // MARK: Public API

    func add(bookmark: BookmarkModel) {
        _bookmarks.insert(bookmark)
        archive()
    }

    func remove(bookmark: BookmarkModel) {
        _bookmarks.remove(bookmark)
        archive()
    }

    func contains(bookmark: BookmarkModel) -> Bool {
        return _bookmarks.contains(bookmark)
    }

    func clear() {
        _bookmarks.removeAll()
        archive()
    }

    var bookmarks: [BookmarkModel] {
        return Array(_bookmarks)
    }

    // MARK: Private API

    func archive() {
        NSKeyedArchiver.archiveRootObject(_bookmarks, toFile: self.archivePath)
    }

}
