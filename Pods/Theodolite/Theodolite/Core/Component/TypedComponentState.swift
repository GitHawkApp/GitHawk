//
//  TypedComponentProps.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/25/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public extension TypedComponent {
  var state: StateType? {
    get {
      if let handle = getScopeHandle(component: self) {
        return handle.state as? StateType
      }
      assert(false, "Accessing state before handle set on component. This state update will no-op")
      return nil
    }
  }
  
  func initialState() -> StateType? {
    return nil
  }
  
  func updateState(state: StateType?) {
    if let handle = getScopeHandle(component: self) {
      handle.stateUpdater(handle.identifier, state)
    } else {
      assert(false, "Updating state before handle set on component. This state update will no-op")
    }
  }
}
