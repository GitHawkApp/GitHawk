//
//  ComponentLayout.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public struct SizeRange: Hashable, Equatable {
  public let min: CGSize
  public let max: CGSize
  
  init(min: CGSize = CGSize(width: CGFloat.nan, height: CGFloat.nan),
       max: CGSize) {
    self.min = min
    self.max = max
  }
  
  public func clamp(_ size: CGSize) -> CGSize {
    return CGSize(
      width: CGFloat.maximum(CGFloat.minimum(size.width, max.width), min.width),
      height: CGFloat.maximum(CGFloat.minimum(size.height, max.height), min.height)
    )
  }
  
  public static func ==(lhs: SizeRange, rhs: SizeRange) -> Bool {
    return SizesEqual(lhs.min, rhs.min)
      && SizesEqual(lhs.max, rhs.max)
  }
  
  public var hashValue: Int {
    return HashArray([
        min.width,
        min.height,
        max.width,
        max.height
      ])
  }
}

internal func StandardLayout(component: Component,
                             constraint: SizeRange,
                             tree: ComponentTree) -> Layout {
  // Check if we can memoize our layout. If you're building your own component layout, you can probably skip this.
  // Instead, just add an empty component in the hierarchy that is a parent of your heavy layout components, and
  // they'll memoize for you instead of duplicating this code.
  let componentContext = GetContext(component)
  if let componentContext = componentContext {
    if let cachedLayout = MemoizedLayout(component: component,
                                         componentContext: componentContext,
                                         constraint: constraint) {
      return cachedLayout
    }
  }

  // No memoized layout, we gotta compute fresh.
  let layoutChildren = tree.children().map { (childTree: ComponentTree) -> LayoutChild in
    return LayoutChild(
      layout:childTree
        .component()
        .layout(constraint: constraint,
                tree: childTree),
      position: CGPoint(x: 0, y: 0))
  }

  // We assume that our size is the union of all child frames, but it doesn't have to be.
  let contentRect = layoutChildren.reduce(
    CGRect.null,
    { (unionRect, layoutChild) -> CGRect in
      return unionRect.union(CGRect(origin: layoutChild.position,
                                    size: layoutChild.layout.size))
  })

  let layout = Layout(
    component: component,
    size: contentRect.size,
    children: layoutChildren)

  if let componentContext = componentContext {
    // Cache the layout so that we can hit the cache if we get asked about this right away.
    StoreLayout(layout: layout,
                componentContext: componentContext,
                constraint: constraint)
  }
  return layout
}

internal func MemoizedLayout(component: Component,
                             componentContext: ComponentContext,
                             constraint: SizeRange) -> Layout? {
  if let previousLayoutInfo = componentContext.layoutInfo.get() {
    if constraint == previousLayoutInfo.constraint {
      return Layout(component: component,
                    size: previousLayoutInfo.size,
                    children: previousLayoutInfo.children,
                    extra: previousLayoutInfo.extra)
    }
  }
  return nil
}

internal func StoreLayout(layout: Layout,
                          componentContext: ComponentContext,
                          constraint: SizeRange) {
  componentContext.layoutInfo.update({ (_) in
    LayoutInfo(constraint: constraint,
               size: layout.size,
               children: layout.children,
               extra: layout.extra) })
}
