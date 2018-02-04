//
//  TextCache.swift
//  Theodolite
//
//  Cloned from https://github.com/apple/swift-corelibs-foundation/blob/master/Foundation/NSCache.swift
//  to fix a bug in NSCache.
//

import Foundation

private class TextCacheEntry<KeyType, ObjectType> where
KeyType : Hashable,
ObjectType : AnyObject {
  var key: KeyType
  var value: ObjectType
  var cost: Int
  var prevByCost: TextCacheEntry?
  var nextByCost: TextCacheEntry?
  init(key: KeyType, value: ObjectType, cost: Int) {
    self.key = key
    self.value = value
    self.cost = cost
  }
}

open class TextCache<KeyType, ObjectType> where
  KeyType : Hashable,
  ObjectType : AnyObject
{

  private var _entries: [KeyType: TextCacheEntry<KeyType, ObjectType>] = [:]
  private let _lock: os_unfair_lock_t = {
    let lock = os_unfair_lock_t.allocate(capacity: 1)
    lock.initialize(to: os_unfair_lock_s(), count: 1)
    return lock
  }()
  private var _totalCost = 0
  private var _head: TextCacheEntry<KeyType, ObjectType>?

  open var name: String = ""
  open var totalCostLimit: Int = 0 // limits are imprecise/not strict
  open var countLimit: Int = 0 // limits are imprecise/not strict
  open var evictsObjectsWithDiscardedContent: Bool = false

  deinit {
    _lock.deinitialize(count: 1)
    _lock.deallocate(capacity: 1)
  }

  open func object(forKey key: KeyType) -> ObjectType? {
    var object: ObjectType?

    os_unfair_lock_lock(_lock)
    if let entry = _entries[key] {
      object = entry.value
    }
    os_unfair_lock_unlock(_lock)

    return object
  }

  open func setObject(_ obj: ObjectType, forKey key: KeyType) {
    setObject(obj, forKey: key, cost: 0)
  }

  private func remove(_ entry: TextCacheEntry<KeyType, ObjectType>) {
    let oldPrev = entry.prevByCost
    let oldNext = entry.nextByCost

    oldPrev?.nextByCost = oldNext
    oldNext?.prevByCost = oldPrev

    if entry === _head {
      _head = oldNext
    }
  }

  private func insert(_ entry: TextCacheEntry<KeyType, ObjectType>) {
    guard var currentElement = _head else {
      // The cache is empty
      entry.prevByCost = nil
      entry.nextByCost = nil

      _head = entry
      return
    }

    guard entry.cost > currentElement.cost else {
      // Insert entry at the head
      entry.prevByCost = nil
      entry.nextByCost = currentElement
      currentElement.prevByCost = entry

      _head = entry
      return
    }

    while currentElement.nextByCost != nil && currentElement.nextByCost!.cost < entry.cost {
      currentElement = currentElement.nextByCost!
    }

    // Insert entry between currentElement and nextElement
    let nextElement = currentElement.nextByCost

    currentElement.nextByCost = entry
    entry.prevByCost = currentElement

    entry.nextByCost = nextElement
    nextElement?.prevByCost = entry
  }

  open func setObject(_ obj: ObjectType, forKey key: KeyType, cost g: Int) {
    let g = max(g, 0)

    os_unfair_lock_lock(_lock)

    let costDiff: Int

    if let entry = _entries[key] {
      costDiff = g - entry.cost
      entry.cost = g

      entry.value = obj

      if costDiff != 0 {
        remove(entry)
        insert(entry)
      }
    } else {
      let entry = TextCacheEntry(key: key, value: obj, cost: g)
      _entries[key] = entry
      insert(entry)

      costDiff = g
    }

    _totalCost += costDiff

    var purgeAmount = (totalCostLimit > 0) ? (_totalCost - totalCostLimit) : 0
    while purgeAmount > 0 {
      if let entry = _head {
        _totalCost -= entry.cost
        purgeAmount -= entry.cost

        remove(entry) // _head will be changed to next entry in remove(_:)
        _entries[entry.key] = nil
      } else {
        break
      }
    }

    var purgeCount = (countLimit > 0) ? (_entries.count - countLimit) : 0
    while purgeCount > 0 {
      if let entry = _head {
        _totalCost -= entry.cost
        purgeCount -= 1

        remove(entry) // _head will be changed to next entry in remove(_:)
        _entries[entry.key] = nil
      } else {
        break
      }
    }

    os_unfair_lock_unlock(_lock)
  }
}
