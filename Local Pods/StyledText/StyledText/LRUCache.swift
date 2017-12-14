//
//  StyledTextRenderCache.swift
//  StyledText
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

//extension CGImage {
//
//    var bytesLength: Int {
//        return height * bytesPerRow
//    }
//
//}

protocol LRUCachable {
    var cachedSize: Int { get }
}

final class LRUCache<Key: Hashable & Equatable, Value: LRUCachable> {

    internal class Node {

        let key: Key
        var value: Value
        var head: Node? = nil
        var tail: Node? = nil

        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }

    enum Compaction {
        case `default`
        case percent(Double)
    }

    private var lock = os_unfair_lock_s()
    
    internal var map = [Key: Node]()
    internal var size: Int = 0
    internal var head: Node?

    let maxSize: Int
    let compaction: Compaction

    init(maxSize: Int, compaction: Compaction = .default) {
        self.maxSize = maxSize
        self.compaction = compaction
    }

    func get(_ key: Key) -> Value? {
        os_unfair_lock_lock(&lock)

        let node = map[key]
        newHead(node: node)

        os_unfair_lock_unlock(&lock)

        return node?.value
    }

    func set(_ key: Key, value: Value) {
        os_unfair_lock_lock(&lock)

        let node: Node
        if let existingNode = map[key] {
            size -= existingNode.value.cachedSize
            existingNode.value = value
            node = existingNode
        } else {
            node = Node(key: key, value: value)
            map[key] = node
        }

        size += value.cachedSize
        newHead(node: node)
        purge()

        os_unfair_lock_unlock(&lock)
    }

    private func newHead(node: Node?) {
        node?.tail = head
        node?.head = nil
        head = node
    }

    private func purge() {
        guard size > maxSize else { return }

        var tail: Node? = head
        while let current = tail {
            tail = current.tail
        }

        let purgeSize: Int
        switch compaction {
        case .default: purgeSize = maxSize
        case .percent(let percent): purgeSize = Int(Double(maxSize) * percent)
        }

        while size > purgeSize, let next = tail {
            size -= next.value.cachedSize
            map.removeValue(forKey: next.key)
            tail = next.tail
        }
    }

}
