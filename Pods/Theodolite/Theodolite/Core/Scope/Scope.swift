//
//  Scope.swift
//  components-swift
//
//  Created by Oliver Rickard on 10/9/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public class Scope: ComponentTree {
  internal let _component: Component
  internal let _handle: ScopeHandle
  internal let _children: [Scope]
  
  /** 
   This is arguably the most complex part of Theodolite. Scopes are an implementation detail of the infrastructure,
   and you should never really have to interact with Scopes if you're working on a Theodolite Component tree.
   
   The core role of scopes is to call render() on each component recursively, and record the children for each
   component. As part of this process of building the component hierarchies, scopes are responsible for matching each
   component with its previous generation, and attaching any prior state, and applying any state updates before calling
   render().
   
   Scopes also keep a reference to the state update listener, and when components call self.updateState(...), they
   actually call through the scope handle to the listener.
   
   One scope is built for each component in the hierarchy.
  */
  init(listener: StateUpdateListener?,
       component: Component,
       previousScope: Scope?,
       parentIdentifier: ScopeIdentifier,
       stateUpdateMap: [ScopeIdentifier: Any?]) {
    // First we have to set up our scope handle before calling render so that the state and state updater are
    // available to the component in render().
    if let prev = previousScope {
      if !findStateUpdatesForChildren(identifier: prev._handle.identifier, stateUpdateMap: stateUpdateMap)
        && !((component as? InternalTypedComponent)?.shouldComponentUpdate(previous: prev._component) ?? true) {
        // Instead of re-building the component, we can just use the previous tree we built
        _component = prev._component
        _handle = prev._handle
        _children = prev._children
        return
      } else {
        _component = component
        _handle = ScopeHandle(
          responder:ScopedResponder(list: prev._handle.responder.responderList, responder: component),
          identifier: prev._handle.identifier,
          state: stateUpdateMap[prev._handle.identifier]
            ?? prev._handle.state) {
              [weak listener] (identifier: ScopeIdentifier, value: Any?) in
              listener?.receivedStateUpdate(identifier: identifier,
                                            update: value)
        }
      }
    } else {
      _component = component
      let typed = component as? InternalTypedComponent
      _handle = ScopeHandle(
        responder: ScopedResponder(list: ResponderList(), responder: component),
        parentIdentifier: parentIdentifier,
        state:typed?.initialUntypedState()) {
          [weak listener](identifier: ScopeIdentifier, state: Any?) -> () in
          listener?.receivedStateUpdate(identifier: identifier, update: state)
      }
    }
    setScopeHandle(component: component, handle: _handle)
    
    let identifier = _handle.identifier
    
    // We're now able to call render, since we've finished setting up the scope handle and state update listener.
    _children = component.render().map { (child) -> Scope in
      // Note this is inefficient if there are a large number of children. We're assuming the number of children is
      // small to begin with, and can convert to a hash map if we add more.
      let prev = previousScope?._children.first(where: { (s: Scope) -> Bool in
        return areComponentsEquivalent(c1: child, c2: s.component())
      })
      
      return Scope(listener: listener,
                   component: child,
                   previousScope: prev,
                   parentIdentifier: identifier,
                   stateUpdateMap: stateUpdateMap)
    }
    
    assert(findCollidingComponents(siblings: _children))
  }
  
  public func children() -> [ComponentTree] {
    return _children
  }
  
  public func component() -> Component {
    return _component
  }
}

internal func findStateUpdatesForChildren(identifier: ScopeIdentifier,
                                          stateUpdateMap: [ScopeIdentifier: Any?]) -> Bool {
  for (otherIdentifier, _) in stateUpdateMap {
    if otherIdentifier.path.starts(with: identifier.path) {
      return true
    }
  }
  return false
}

internal func findCollidingComponents(siblings: [Scope]) -> Bool {
  let identifiers = Set(siblings.map({ $0._handle.identifier }))
  if identifiers.count == siblings.count {
    return true
  }
  
  var seen: [ScopeIdentifier: Scope] = [:]
  var foundDuplicates = false
  for scope in siblings {
    if let duplicate = seen[scope._handle.identifier] {
      print("Duplicate scope, add a key: \(duplicate._component), \(scope._component)")
      foundDuplicates = true
    }
    seen[scope._handle.identifier] = scope
  }
  return !foundDuplicates
}

internal func areComponentsEquivalent(c1: Component, c2: Component) -> Bool {
  return type(of: c1) == type(of: c2)
    && c1.key == c2.key
}
