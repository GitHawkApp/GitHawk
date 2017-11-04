//
//  BookmarkStore.swift
//  Freetime
//
//  Created by Rizwan on 18/10/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public protocol BookmarksStoreListener: class {
    func bookmarksDidUpdate()
}

final class BookmarksStore {

    private class ListenerWrapper: NSObject {
        weak var listener: BookmarksStoreListener?
    }

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
    private var _bookmarks: NSMutableOrderedSet = []
    private var listeners: [ListenerWrapper] = []

    // MARK: Init

    init(_ userToken: String) {
        token = userToken
        refresh()
    }

    // MARK: Public API

    func add(listener: BookmarksStoreListener) {
        let wrapper = ListenerWrapper()
        wrapper.listener = listener
        listeners.append(wrapper)
    }

    func add(bookmark: BookmarkModel) {
        _bookmarks.add(bookmark)
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
        _bookmarks.removeAllObjects()
        archive()
    }

    var bookmarks: [BookmarkModel] {
        refresh()
        guard let bookmarks = _bookmarks.array as? [BookmarkModel] else {
            return []
        }

        return bookmarks
    }

    // MARK: Private API
    
    func refresh() {
        if let bookmarks = NSKeyedUnarchiver.unarchiveObject(withFile: archivePath) as? NSMutableOrderedSet {
            _bookmarks = bookmarks
        }
    }

    func archive() {
        NSKeyedArchiver.archiveRootObject(_bookmarks, toFile: archivePath)
        for wrapper in listeners {
            if let listener = wrapper.listener {
                listener.bookmarksDidUpdate()
            }
        }
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
