//
//  Utilities.swift
//  components-swift
//
//  Created by Oliver Rickard on 10/9/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

func setAssociatedObject<T>(object: AnyObject, value: T, associativeKey: UnsafeRawPointer) {
  objc_setAssociatedObject(object,
                           associativeKey,
                           value,
                           objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
}

func getAssociatedObject<T>(object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
  if let v = objc_getAssociatedObject(object, associativeKey) as? T {
    return v
  }
  
  return nil
}

/* Since apple deprecated OSAtomic methods, we use this little container instead. */
public class Atomic<T> {
  var val: T
  var lock: os_unfair_lock_t
  
  init(_ val: T) {
    self.val = val
    self.lock = os_unfair_lock_t.allocate(capacity: 1)
    self.lock.initialize(to: os_unfair_lock_s(), count: 1)
  }
  
  deinit {
    lock.deinitialize(count: 1)
    lock.deallocate(capacity: 1)
  }
  
  func get() -> T {
    os_unfair_lock_lock(lock); defer { os_unfair_lock_unlock(lock) }
    return self.val
  }
  
  @discardableResult
  func update(_ updater: (T) -> T) -> T {
    var newVal: T? = nil
    os_unfair_lock_lock(lock); defer { os_unfair_lock_unlock(lock) }
    newVal = updater(self.val)
    self.val = newVal!
    return newVal!
  }
}

func HashCombine(_ first: AnyHashable, _ second: AnyHashable) -> Int {
  #if arch(x86_64) || arch(arm64)
    let magic: UInt = 0x9e3779b97f4a7c15
  #elseif arch(i386) || arch(arm)
    let magic: UInt = 0x9e3779b9
  #endif
  var lhs = UInt(bitPattern: first.hashValue)
  let rhs = UInt(bitPattern: second.hashValue)
  lhs ^= rhs &+ magic &+ (lhs << 6) &+ (lhs >> 2)
  return Int(bitPattern: lhs)
}

func HashArray(_ values: [AnyHashable]) -> Int {
  let value = values.reduce(0) { (result: Int, val: AnyHashable) -> Int in
    return HashCombine(result, val.hashValue)
  }
  return value
}

class WeakContainer<T: AnyObject> {
  weak var val: T?
  
  init(_ val: T) {
    self.val = val
  }
}

func SizesEqual(_ size1: CGSize, _ size2: CGSize) -> Bool {
  return FloatsEqual(size1.width, size2.width) && FloatsEqual(size1.height, size2.height)
}

func FloatsEqual(_ val1: CGFloat, _ val2: CGFloat) -> Bool {
  if val1.isNaN && val2.isNaN {
    return true
  }
  return val1 == val2
}
