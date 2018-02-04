//
//  ScopeHandle.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/11/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

/**
 When a component is found to be completely new, it is assigned a simple integer which is monotonically increasing.
 
 This lets us centralize the identifier comparison code into a single callsite inside Scope itself, and everyone else
 can just use an integer for rapid comparisons and lookups by component.
 
 You can think about a scope handle's identifier as the *result* of the identification operation. Note this is global
 to the entire app.
 */
var __currentIdentifier: Atomic<Int32> = Atomic<Int32>(0)

public struct ScopeIdentifier: Equatable, Hashable {
  let path: [Int32]
  
  public func append(_ val: Int32) -> ScopeIdentifier {
    var copiedPath = path
    copiedPath.append(val)
    return ScopeIdentifier(path: copiedPath)
  }
  
  public var hashValue: Int {
    return path.reduce(0, { (combined, next) -> Int in
      return HashCombine(combined, next)
    })
  }
  
  static public func ==(lhs: ScopeIdentifier, rhs: ScopeIdentifier) -> Bool {
    return lhs.path == rhs.path
  }
}

/**
 Internal bag of data that contains the information that the framework associates with a given logical component
 through its generations.
 */
public class ScopeHandle {
  let identifier: ScopeIdentifier
  let state: Any?
  let stateUpdater: (ScopeIdentifier, Any?) -> ()
  let responder: ScopedResponder
  
  convenience init(responder: ScopedResponder, parentIdentifier: ScopeIdentifier, state: Any?, stateUpdater: @escaping (ScopeIdentifier, Any?) -> ()) {
    self.init(responder: responder, identifier: parentIdentifier.append(__currentIdentifier.update({ (val: Int32) -> Int32 in
      return val + 1
    })), state: state, stateUpdater: stateUpdater)
  }
  
  init(responder: ScopedResponder, identifier: ScopeIdentifier, state: Any?, stateUpdater: @escaping (ScopeIdentifier, Any?) -> ()) {
    self.identifier = identifier
    self.state = state
    self.stateUpdater = stateUpdater
    self.responder = responder
  }
}

var kScopeHandleKey: Void?

internal func setScopeHandle(component: AnyObject, handle: ScopeHandle) {
  (component as? UnTypedComponent)?.context.scopeHandle = handle
}

internal func getScopeHandle(component: AnyObject) -> ScopeHandle? {
  return (component as? UnTypedComponent)?.context.scopeHandle
}
