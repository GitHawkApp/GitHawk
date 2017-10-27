//
//  BookmarkStore.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

final class BookmarksStore {

    private let fileManager = FileManager.default
    private var documentDirectory: FileManager.SearchPathDirectory {
        return .documentDirectory
    }

    private var archivePath: String {
        guard let path = NSSearchPathForDirectoriesInDomains(documentDirectory, .userDomainMask, true).first else {
            fatalError("App document directory cannot be found")
        }

        let folder = URL(fileURLWithPath: path).appendingPathComponent("com.whoisryannystrom.freetime.bookmarks")
        if !fileManager.fileExists(atPath: folder.path) {
            try? fileManager.createDirectory(at: folder, withIntermediateDirectories: false, attributes: nil)
        }
        return folder.appendingPathComponent(token).path
    }

    private var token: String
    private var _bookmarks: Set<BookmarkModel> = []

    // MARK: Init

    init(_ userToken: String?) {
        guard let userToken = userToken else { fatalError() }
        token = userToken
        refresh()
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
        refresh()
        return Array(_bookmarks)
    }

    // MARK: Private API
    
    func refresh() {
        if let bookmarks = NSKeyedUnarchiver.unarchiveObject(withFile: archivePath) as? Set<BookmarkModel> {
            _bookmarks = bookmarks
        }
    }

    func archive() {
        NSKeyedArchiver.archiveRootObject(_bookmarks, toFile: archivePath)
    }

    func clearStorage() {
        do {
            try FileManager.default.removeItem(atPath: archivePath)
        } catch {
            print("Can not delete bookmarks file")
        }
    }

    var bookmarkPath: String {
        return archivePath
    }
}
