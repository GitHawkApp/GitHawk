//
//  TypedComponent.swift
//  components-swift
//
//  Created by Oliver Rickard on 10/9/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

/**
 TypedComponent is the standard protocol that your components should conform to.
 
 It allows you to declare the prop types and state types for your component, and implements most of the core
 methods for you in an extension.
 
 Here's what a component would look like:
 
 final class MyComponent: TypedComponent {
   typealias PropType = String
   // Note that state type is optional
 }
 
 Then you can construct this component like so:
 
 MyComponent { "Hello World" }
 
 If your component requires more than one input value, then you may use a tuple:
 
 final class MyComponent: TypedComponent {
   typealias PropType = (
     string: String,
     val: Int
   )
 }
 
 MyComponent { (string: "Hello World",
                val: 42) }
 
 State can be defined similar to props, by using a typealias:
 
 final class MyComponent: TypedComponent {
   typealias PropType = String
   typealias StateType = String
 }
 
 Note that state is entirely private to the component, external users of the component should never access its state.
 
 Also, please note that while props are available immediately after init, state isn't available until just before
 render() is called.
 
 You may update your state on your component by calling updateState() with a new value.
 */
public protocol TypedComponent: UnTypedComponent, InternalTypedComponent {
  associatedtype ComponentType: Component = Self
  associatedtype PropType
  associatedtype StateType = Void?
  
  var props: PropType {get}
  var state: StateType? {get}
  
  func initialState() -> StateType?
  
  func updateState(state: StateType?)
  
  init(key: AnyHashable?,
       _ props: PropType)
}
