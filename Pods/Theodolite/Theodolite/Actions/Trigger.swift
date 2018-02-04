//
//  Trigger.swift
//  Theodolite
//
//  Created by Oliver Rickard on 11/18/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

/**
 Triggers allow a parent component to invoke a method on a child component without keeping a reference to that
 component.

 Triggers are conceptually similar to Actions, but they work in the opposite direction. Actions let a child component
 inform a parent when a particular event takes place (think: tapped on a button in the child). Triggers on the other
 hand let the parent component tell the child component to do something.

 Why is this not a violation of the React single-directional data flow? Well, it kind of is, but it's useful for
 classes of things that occur frequently and you want to avoid the cost of reflowing the hierarchy.

 Don't use this as a crutch, use it when you find that the normal updateState mechanism is too slow (aka doing something
 on every scroll tick).

 Example usage:

 final class ParentComponent: Component, TypedComponent {
    typealias PropType = Void

    private let trigger: Trigger<String> = Trigger<String>()

    override func render() -> [Component] {
      return [
        ChildComponent( trigger )
      ]
    }

    func somethingHappened() {
      trigger.invoke("Luke, I am your father")
    }
  }

  final class ChildComponent: Component, TypedComponent {
    typealias PropType = Trigger<String>

    override func render() -> [Component] {
      // Note that the child has to resolve inside of render(). If the trigger isn't resolved, it won't invoke anything.
      props.resolve(Handler(self, ChildComponent.willBeInvoked))
      return []
    }

    func willBeInvoked(string: String) {
      print("\(string)")
    }
  }
 */
public class Trigger<Arg>: Equatable, Hashable {
  private var action: Action<Arg>?
  public init() {}

  /**
   Gives the trigger something to actually invoke when the parent component calls invoke(...)
   */
  public func resolve(_ action: Action<Arg>) {
    assert(self.action == nil)
    self.action = action
  }

  /**
   Calls whatever action this trigger was resolved with.
   */
  public func invoke(_ argument: Arg) {
    self.action?.send(argument)
  }

  public static func ==<T>(lhs: Trigger<T>, rhs: Trigger<T>) -> Bool {
    return lhs === rhs
  }

  public var hashValue: Int {
    return ObjectIdentifier(self).hashValue
  }
}
