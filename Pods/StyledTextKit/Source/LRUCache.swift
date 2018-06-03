//
//  StyledTextKitRenderCache.swift
//  StyledTextKit
//
//  Created by Ryan Nystrom on 12/13/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

public protocol LRUCachable {
    var cachedSize: Int { get }
}

public final class LRUCache<Key: Hashable & Equatable, Value: LRUCachable> {

    internal class Node {

        // for reverse lookup in map
        let key: Key
        // mutable b/c you can change the value for an existing key
        var value: Value
        // 2-way linked list
        var previous: Node? = nil
        var next: Node? = nil

        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }

        var tail: Node? {
            var t: Node? = self
            while let next = t?.next {
                t = next
            }
            return t
        }
    }

    public enum Compaction {
        case `default`
        case percent(Double)
    }

    // thread safety
    private var lock = os_unfair_lock_s()

    // mutable collection state
    internal var map = [Key: Node]()
    internal var size: Int = 0
    internal var head: Node?

    public let maxSize: Int
    public let compaction: Compaction

    public init(maxSize: Int, compaction: Compaction = .default, clearOnWarning: Bool = false) {
        self.maxSize = maxSize

        switch compaction {
        case .default: self.compaction = compaction
        case .percent(let percent):
            if percent <= 0 || percent > 1 {
                self.compaction = .default
            } else {
                self.compaction = compaction
            }
        }

        if clearOnWarning {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(clear),
                name: .UIApplicationDidReceiveMemoryWarning,
                object: nil
            )
        }
    }

    public func get(_ key: Key) -> Value? {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }

        let node = map[key]
        newHead(node: node)
        return node?.value
    }

    public func set(_ key: Key, value: Value?) {
        guard let value = value else { return }

        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }

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
        compact()
    }

    public subscript(key: Key) -> Value? {
        get {
            return get(key)
        }
        set(newValue) {
            set(key, value: newValue)
        }
    }

    @objc public func clear() {
        os_unfair_lock_lock(&lock)
        defer { os_unfair_lock_unlock(&lock) }

        head = nil
        map.removeAll()
        size = 0
    }

    // unsafe to call w/out nested in lock
    private func newHead(node: Node?) {
        // fill in the gap and break cycles
        node?.previous?.next = node?.next

        head?.previous = node

        node?.next = head
        node?.previous = nil

        head = node
    }

    // unsafe to call w/out nested in lock
    private func compact() {
        guard size > maxSize else { return }

        var tail = head?.tail

        let compactSize: Int
        switch compaction {
        case .default: compactSize = maxSize
        case .percent(let percent): compactSize = Int(Double(maxSize) * percent)
        }

        while size > compactSize, let next = tail {
            size -= next.value.cachedSize
            map.removeValue(forKey: next.key)
            tail = next.previous
        }
    }

}
