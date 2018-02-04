//
//  ComponentContext.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

internal func GetContext(_ component: Component) -> ComponentContext? {
  return component.context
}

public protocol MountInfoProtocol {
  var mountContext: MountContext? {get set}
  var mountedLayout: Layout? {get set}
}

public struct MountInfo: MountInfoProtocol {
  public var currentView: UIView? = nil
  public var mountContext: MountContext? = nil
  public var mountedLayout: Layout? = nil
}

public struct LayoutInfo {
  /** We can't store a ref to the Layout directly because that would form a retain cycle. */
  let constraint: SizeRange
  let size: CGSize
  let children: [LayoutChild]
  let extra: Any?
}

/** The bag of information needed by the framework to do its work. This is an implementation detail of the framework. */
public class ComponentContext {
  internal var props: Any? = nil
  internal var key: AnyHashable? = nil
  internal var scopeHandle: ScopeHandle? = nil
  
  public var mountInfo: MountInfo = MountInfo()
  public var layoutInfo: Atomic<LayoutInfo?> = Atomic(nil)

  public init() {}
}
