//
//  InternalTypedComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/11/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

/* Used by infrastructure to allow polymorphism on prop/state types. */
public protocol UnTypedComponent: AnyObject {
  var context: ComponentContext {get}

  init(doNotCall key: AnyHashable?)
}

public protocol InternalTypedComponent {
  func initialUntypedState() -> Any?
  
  func shouldComponentUpdate(previous: Component) -> Bool
}

/* Default implementations of the core methods. You shouldn't override any of these methods. */
public extension TypedComponent {
  public init(key: AnyHashable? = nil,
              _ props: PropType) {
    self.init(doNotCall: key)
    
    self.context.props = props
    self.context.key = key
  }
  
  public func shouldComponentUpdate(previous: Component) -> Bool {
    // Note that we don't use self.props here, since that force-unwraps props
    if let props = self.context.props as? AnyHashable {
      if let previousProps = (previous as? Self)?.context.props as? AnyHashable {
        return props != previousProps
      }
    }
    return true
  }
  
  /* Implementation detail, ignore this. TODO: Remove? */
  func initialUntypedState() -> Any? {
    return initialState()
  }
}
