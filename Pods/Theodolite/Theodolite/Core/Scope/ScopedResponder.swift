//
//  ScopedResponder.swift
//  Theodolite
//
//  Created by Oliver Rickard on 11/4/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

/**
 Maintains a weak list of all generations of components for a particular scope.

 Components are constantly being re-generated in response to state updates. This means that if an action were to
 capture a component, and then get dispatched to do some work, when it returns to the main thread, then the action
 may be pointing at nil now.

 ResponderList keeps a list of all of the new component generations, and if the component it was originally targeting
 is nil, it just walks forward in the generations until it finds one that's alive still, and invokes the action on
 that component instead.
 */
internal class ResponderList {
  private let lock: os_unfair_lock_t = {
    let lock = os_unfair_lock_t.allocate(capacity: 1)
    lock.initialize(to: os_unfair_lock_s(), count: 1)
    return lock
  }()
  private var responders: NSPointerArray = NSPointerArray.weakObjects()

  deinit {
    lock.deinitialize(count: 1)
    lock.deallocate(capacity: 1)
  }

  internal func append(_ object: AnyObject) -> Int {
    os_unfair_lock_lock(lock); defer { os_unfair_lock_unlock(lock) }
    let index = responders.count
    responders.addPointer(Unmanaged.passUnretained(object).toOpaque())
    return index
  }

  internal func getResponder(_ index: Int) -> AnyObject? {
    if index >= responders.count {
      return nil
    }

    var candidate: AnyObject? = object(at: index)
    var currentIndex = index
    while currentIndex + 1 < responders.count && candidate == nil {
      currentIndex += 1
      candidate = object(at: currentIndex)
    }
    return candidate
  }

  private func object(at index: Int) -> AnyObject? {
    if let ptr = responders.pointer(at: index) {
      return Unmanaged<AnyObject>.fromOpaque(ptr).takeUnretainedValue()
    } else {
      return nil
    }
  }
}

/**
 The ScopedResponder is the actual object that is captured by the scope handle, and is that scope handle's way of
 accessing the "current" components in the generations of components.

 It holds onto the global responder list for a particular component, and keeps a reference of where to start in this
 list when it looks for the current component. This captureIndex is important, since without it, if we were to just
 start from the beginning of the list, we could end up having terrible behavior in the case of a memory leak. The
 captureIndex allows the scoped responder to only ever reference a newer component generation than the one it was
 captured in.
 */
internal struct ScopedResponder {
  internal let responderList: ResponderList
  private let captureIndex: Int

  init(list: ResponderList, responder: AnyObject) {
    self.captureIndex = list.append(responder)
    self.responderList = list
  }

  init() {
    self.captureIndex = 0
    self.responderList = ResponderList()
  }

  func responder() -> AnyObject? {
    return self.responderList.getResponder(self.captureIndex)
  }
}
