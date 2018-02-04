//
//  StateUpdateListener.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/11/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

/**
 Protocol for state update listeners.
 
 This protocol is used to announce when any component in a hierarchy has requested a state update. It should be
 implemented by any hosting infrastructure that renders and re-renders components in response to state updates.
 */
public protocol StateUpdateListener: class {
  func receivedStateUpdate(identifier: ScopeIdentifier, update: Any?)
}
