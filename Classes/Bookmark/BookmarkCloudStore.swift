//
//  BookmarkCloudStore.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/23/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation

final class BookmarkIDCloudStore {

    /**
     TODO
     - listeners array
     - register to icloud updates
     - when mutating via add() or icloud, notify listeners
     */

    private let iCloudStore = NSUbiquitousKeyValueStore()
    private let username: String

    init(username: String) {
        self.username = username
    }

    private var storage: NSMutableOrderedSet {
        assert(Thread.isMainThread)
        return iCloudStore.mutableOrderedSetValue(forKey: "bookmarks-\(username)")
    }

    func contains(graphQLID: String) -> Bool {
        assert(Thread.isMainThread)
        return storage.contains(graphQLID)
    }

    func add(graphQLID: String) {
        assert(Thread.isMainThread)
        storage.add(graphQLID)
        iCloudStore.synchronize()
    }

    func add(graphQLIDs: [String]) {
        assert(Thread.isMainThread)
        storage.addObjects(from: graphQLIDs)
        iCloudStore.synchronize()
    }

    func remove(graphQLID: String) {
        assert(Thread.isMainThread)
        storage.remove(graphQLID)
        iCloudStore.synchronize()
    }

    var ids: [String] {
        return storage.array as? [String] ?? []
    }

}
