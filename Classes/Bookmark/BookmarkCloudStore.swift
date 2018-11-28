//
//  BookmarkCloudStore.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol BookmarkIDCloudKeyValueStore {
    func savedBookmarks(for key: String) -> NSMutableOrderedSet
    func set(bookmarks: NSMutableOrderedSet, for key: String)
    @discardableResult func synchronize() -> Bool
}

// use in app
extension NSUbiquitousKeyValueStore: BookmarkIDCloudKeyValueStore {
    func savedBookmarks(for key: String) -> NSMutableOrderedSet {
        if let arr = array(forKey: key) as? [String] {
            return NSMutableOrderedSet(array: arr)
        }
        return NSMutableOrderedSet()
    }

    func set(bookmarks: NSMutableOrderedSet, for key: String) {
        set(bookmarks.array, forKey: key)
    }
}

// use for tests
extension UserDefaults: BookmarkIDCloudKeyValueStore {
    func savedBookmarks(for key: String) -> NSMutableOrderedSet {
        if let arr = array(forKey: key) as? [String] {
            return NSMutableOrderedSet(array: arr)
        }
        return NSMutableOrderedSet()
    }

    func set(bookmarks: NSMutableOrderedSet, for key: String) {
        set(bookmarks.array, forKey: key)
    }
}

protocol BookmarkIDCloudStoreListener: class {
    func didUpdateBookmarks(in store: BookmarkIDCloudStore)
}

private class BookmarkListenerWrapper {
    init(listener: BookmarkIDCloudStoreListener) {
        self.listener = listener
    }
    weak var listener: BookmarkIDCloudStoreListener?
}

final class BookmarkIDCloudStore {

    let username: String

    private var listeners = [BookmarkListenerWrapper]()
    private let iCloudStore: BookmarkIDCloudKeyValueStore
    private let key: String
    private var storage: NSMutableOrderedSet

    init(
        username: String,
        iCloudStore: BookmarkIDCloudKeyValueStore = NSUbiquitousKeyValueStore()
        ) {
        self.username = username
        let key = "bookmarks.\(username)"
        self.key = key
        self.iCloudStore = iCloudStore
        self.storage = iCloudStore.savedBookmarks(for: key)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(iCloudDidUpdate),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: nil
        )
    }

    func contains(graphQLID: String) -> Bool {
        assert(Thread.isMainThread)
        return storage.contains(graphQLID)
    }

    func add(graphQLID: String) {
        assert(Thread.isMainThread)
        guard storage.contains(graphQLID) == false else { return }
        storage.add(graphQLID)
        save()
        enumerateListeners { $0.didUpdateBookmarks(in: self) }
    }

    func add(graphQLIDs: [String]) {
        assert(Thread.isMainThread)
        storage.addObjects(from: graphQLIDs)
        save()
        enumerateListeners { $0.didUpdateBookmarks(in: self) }
    }

    func remove(graphQLID: String) {
        assert(Thread.isMainThread)
        guard storage.contains(graphQLID) else { return }
        storage.remove(graphQLID)
        save()
        enumerateListeners { $0.didUpdateBookmarks(in: self) }
    }

    var ids: [String] {
        assert(Thread.isMainThread)
        return storage.array as? [String] ?? []
    }

    func add(listener: BookmarkIDCloudStoreListener) {
        assert(Thread.isMainThread)
        listeners.append(BookmarkListenerWrapper(listener: listener))
    }

    private func save() {
        assert(Thread.isMainThread)
        iCloudStore.set(bookmarks: storage, for: key)
        iCloudStore.synchronize()
    }

    private func enumerateListeners(block: (BookmarkIDCloudStoreListener) -> Void) {
        listeners.forEach {
            if let listener = $0.listener {
                block(listener)
            }
        }
    }

    @objc func iCloudDidUpdate() {
        iCloudStore.synchronize()
        storage = iCloudStore.savedBookmarks(for: key)
        enumerateListeners { $0.didUpdateBookmarks(in: self) }
    }

}
