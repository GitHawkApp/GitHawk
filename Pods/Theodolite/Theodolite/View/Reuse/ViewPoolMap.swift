//
//  ViewPoolMap.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/11/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

var kViewPoolMapKey: Void?

/**
 An internal map that maintains the list of Theodolite-managed views for any given view.
 
 There is one view pool map associated with every Theodolite view when a child mounts into that view. The view pool
 maps are generated lazily.
 
 View pool maps internally store a hash map of view configurations to view pools. By keying on view configurations,
 we ensure that if we hit a view pool, all views can be reconfigured for the component that's asking for a view.
 */
public class ViewPoolMap {
  var hashMap: [ViewConfiguration.AttributeShape:ViewPool] = [:]
  var vendedViews: [UIView] = []
  
  static public func resetViewPoolMap(view: UIView) {
    assert(Thread.isMainThread)
    // No need to create one if it doesn't already exist
    if let map: ViewPoolMap? =
      getAssociatedObject(
        object: view,
        associativeKey: &kViewPoolMapKey) {
      map?.reset(view: view)
    }
  }
  
  static public func getViewPoolMap(view: UIView) -> ViewPoolMap {
    assert(Thread.isMainThread)
    let map: ViewPoolMap? =
      getAssociatedObject(
        object: view,
        associativeKey: &kViewPoolMapKey)
    
    let unwrapped = map ?? ViewPoolMap()
    
    if map == nil {
      setAssociatedObject(object: view,
                          value: unwrapped,
                          associativeKey: &kViewPoolMapKey)
    }
    return unwrapped
  }
  
  public func checkoutView(component: Component, parent: UIView, config: ViewConfiguration) -> UIView? {
    assert(Thread.isMainThread)
    guard let view = getViewPool(view: parent, config: config)
      .checkoutView(component: component, parent: parent, config: config) else {
        return nil
    }
    vendedViews.append(view)
    return view
  }
  
  public func checkinView(component: Component, parent: UIView, config: ViewConfiguration, view: UIView) {
    assert(Thread.isMainThread)
    let pool = getViewPool(view: parent, config: config)
    pool.checkinView(component: component, view: view)
  }
  
  func getViewPool(view: UIView, config: ViewConfiguration) -> ViewPool {
    assert(Thread.isMainThread)
    if let pool = hashMap[ViewConfiguration.AttributeShape(config: config)] {
      return pool
    }
    
    let pool = ViewPool()
    hashMap[ViewConfiguration.AttributeShape(config: config)] = pool
    return pool
  }
  
  func reset(view: UIView) {
    assert(Thread.isMainThread)
    for (_, pool) in hashMap {
      pool.reset()
    }
    
    // This algorithm is a clone of the one in ViewPoolMap in ComponentKit
    
    var subviews = view.subviews
    var nextVendedViewIt = IteratorWrapper(vendedViews)
    
    for i in 0 ..< subviews.count {
      let subview = subviews[i]
      
      // We use linear search here. We could create a std::unordered_set of vended views, but given the typical size of
      // the list of vended views, I guessed a linear search would probably be faster considering constant factors.
      guard let vendedViewIndex = nextVendedViewIt.find(subview) else {
        // Ignore subviews not created by components infra, or that were not vended during this pass (they are hidden).
        continue
      }
      
      if vendedViewIndex != nextVendedViewIt.offset {
        guard let swapIndex = subviews.index(of: nextVendedViewIt.current!) else {
          assertionFailure("Expected to find subview \(subview) in \(view)")
          continue
        }
        
        // This naive algorithm does not do the minimal number of swaps. But it's simple, and swaps should be relatively
        // rare in any case, so let's go with it.
        subviews.swapAt(i, swapIndex)
        view.exchangeSubview(at: i, withSubviewAt: swapIndex)
      }
      
      nextVendedViewIt.advance()
    }
    
    vendedViews.removeAll()
  }
}
