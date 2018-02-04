//
//  ComponentHostingView.swift
//  TheodoliteFeed
//
//  Created by Oliver Rickard on 10/13/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public protocol ComponentHostingViewDelegate: class {
  func hostingViewDidUpdate(hostingView: ComponentHostingView)
}

/**
 A UIView that can host a Theodolite Component hierarchy. This is intended to be a bridge view into UIKit-land. There
 should really only be one of these at the root of the view hierarchy, directly owned by the view controller.
 
 The hosting view's initial render has to be synchronous, however it does attempt a best-effort async layout pass
 in response to state updates. This should generally allow minimal main-thread impact from re-generating the component
 after a user action.
 
 The hosting view itself (and the Theodolite infra) doesn't break up huge component hierarchies for you, so large
 scrolling list views should be rendered inside the hosting view using specific components that handle this.
 */
public final class ComponentHostingView: UIView, StateUpdateListener {
  struct CachedLayout {
    let constraint: CGSize
    let layout: Layout
  }
  
  public var factory: () -> Component {
    didSet {
      self.root = ScopeRoot(previousRoot: self.root,
                            listener: self,
                            stateUpdateMap: self.stateUpdateMap,
                            factory: self.factory)
      self.setNeedsLayout()
    }
  }


  var root: ScopeRoot?
  weak var delegate: ComponentHostingViewDelegate?
  
  // MARK: Private properties
  private var lastLayout: CachedLayout?
  private var incrementalMountContext: IncrementalMountContext = IncrementalMountContext()
  private var mountedLayout: Layout?
  private var stateUpdateMap: [ScopeIdentifier:Any?] = [:]
  private var dispatched: Bool = false
  
  public init(factory: @escaping () -> Component) {
    self.factory = factory
    super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    self.root = ScopeRoot(previousRoot: self.root,
                          listener: self,
                          stateUpdateMap: self.stateUpdateMap,
                          factory: self.factory)
  }
  
  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override public func layoutSubviews() {
    super.layoutSubviews()

    if let mountedLayout = self.mountedLayout {
      // If we're being forced to lay out, we need to detach all views before re-attaching
      UnmountLayout(layout: mountedLayout,
                    incrementalContext: incrementalMountContext)
    }
    
    // First check if we have a cached layout that is still valid
    if let cachedLayout = self.lastLayout {
      if cachedLayout.constraint == self.bounds.size {
        self.mountLayout(layout: cachedLayout.layout)
        return
      }
    }
    
    if let root = self.root {
      let layout = root.root.component().layout(constraint: SizeRange(max: self.bounds.size),
                                                tree: root.root)
      self.mountLayout(layout: layout)
      self.lastLayout = CachedLayout(constraint: self.bounds.size, layout: layout)
    }
  }
  
  // MARK: Component generation/mounting
  
  func mountLayout(layout: Layout) {
    self.mountedLayout = layout
    MountRootLayout(view: self,
                    layout: layout,
                    position: CGPoint(x: 0, y: 0),
                    incrementalContext: incrementalMountContext)

    self.delegate?.hostingViewDidUpdate(hostingView: self)
  }
  
  func markNeedsReset() {
    assert(Thread.isMainThread)
    if self.dispatched {
      return
    }
    
    self.dispatched = true
    let stateUpdateMap = self.stateUpdateMap
    self.stateUpdateMap.removeAll()
    let previousRoot = self.root
    let factory = self.factory
    let constraint = self.bounds.size
    DispatchQueue.global().async {
      let newRoot = ScopeRoot(previousRoot: previousRoot,
                              listener: self,
                              stateUpdateMap: stateUpdateMap,
                              factory: factory)
      // This is a best-effort layout attempt. We can't guarantee that the hosting view won't change its bounds before
      // we apply our update. When that happens in layoutSubviews, we will throw out this layout and will re-compute
      // using the new bounds.
      let newLayout = newRoot.root.component().layout(constraint: SizeRange(max: constraint),
                                                      tree: newRoot.root)
      DispatchQueue.main.async(execute: {
        self.dispatched = false
        self.root = newRoot
        self.lastLayout = CachedLayout(constraint: constraint, layout: newLayout)
        self.setNeedsLayout()
        if (self.stateUpdateMap.count > 0) {
          self.markNeedsReset()
        }
      })
    }
  }
  
  // MARK: StateUpdateListener
  
  public func receivedStateUpdate(identifier: ScopeIdentifier, update: Any?) {
    let block = {
      self.stateUpdateMap[identifier] = update
      self.markNeedsReset()
    }

    if !Thread.isMainThread {
      DispatchQueue.main.async(execute: block)
    } else {
      block()
    }
  }
}
