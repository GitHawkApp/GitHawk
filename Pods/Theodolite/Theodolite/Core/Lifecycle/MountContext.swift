//
//  MountContext.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/25/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public class MountContext {
  /** The view that children should receive as their parent. */
  let view: UIView
  /** The starting position for all children within the view. */
  let position: CGPoint
  /**
   Whether the recursive mount algorithm should mount the children. If you return false, you will have to call
   MountRootLayout yourself.
   */
  let shouldMountChildren: Bool
  
  init(view: UIView,
       position: CGPoint,
       shouldMountChildren: Bool) {
    self.view = view
    self.position = position
    self.shouldMountChildren = shouldMountChildren
  }
}

/**
 IncrementalMountContext is used for bookkeeping. It records which components are mounted so that we can remember to
 unmount components when they're no longer in the hierarchy.
 */
public class IncrementalMountContext {
  private var mounted: Set<Layout> = Set()
  private var marked: Set<Layout> = Set()
  
  internal func isMounted(layout: Layout) -> Bool {
    return mounted.contains(layout)
  }
  
  internal func markMounted(layout: Layout) {
    assert(Thread.isMainThread)
    mounted.insert(layout)
    marked.insert(layout)
  }
  
  internal func markUnmounted(layout: Layout) {
    assert(Thread.isMainThread)
    mounted.remove(layout)
    marked.remove(layout)
  }
  
  internal func unmarkedMounted() -> [Layout] {
    assert(Thread.isMainThread)
    if mounted.count == 0 || mounted == marked {
      return []
    }
    // todo, this is really slow
    return Array(mounted.subtracting(marked))
  }
  
  internal func enumerate(_ closure: (Layout) -> ()) {
    assert(Thread.isMainThread)
    for layout in mounted {
      closure(layout)
    }
  }
}

public func UnmountLayout(layout: Layout,
                          incrementalContext: IncrementalMountContext) {
  // Call willUnmount before recurring
  layout.component.componentWillUnmount()
  
  for childLayout in layout.children {
    if (incrementalContext.isMounted(layout: layout)) {
      UnmountLayout(layout: childLayout.layout,
                    incrementalContext: incrementalContext)
    }
  }
  
  // Only unmount **after** all children are unmounted.
  layout.component.unmount(layout: layout)
  let componentContext = GetContext(layout.component)
  incrementalContext.markUnmounted(layout: layout)
  componentContext?.mountInfo.mountContext = nil
}

public func MountRootLayout(view: UIView,
                            layout: Layout,
                            position: CGPoint,
                            incrementalContext: IncrementalMountContext,
                            mountVisibleOnly: Bool = false) {
  MountLayout(view: view,
              layout: layout,
              position: position,
              incrementalContext: incrementalContext,
              mountVisibleOnly: mountVisibleOnly)
  
  let toBeUnmounted = incrementalContext.unmarkedMounted()
  for unmountingLayout in toBeUnmounted {
    UnmountLayout(layout: unmountingLayout, incrementalContext: incrementalContext)
  }
}

internal func MountLayout(view: UIView,
                          layout: Layout,
                          position: CGPoint,
                          incrementalContext: IncrementalMountContext,
                          mountVisibleOnly: Bool) {
  let component = layout.component
  
  // If the component itself is not mounted, we do that first.
  var needsDidMount = false

  let componentContext = GetContext(layout.component)
  
  if !incrementalContext.isMounted(layout: layout) {
    component.componentWillMount()
    let context = component.mount(parentView: view,
                                  layout: layout,
                                  position: position)
    componentContext?.mountInfo.mountContext = context
    needsDidMount = true
  }
  
  // If we mounted, we need to notify the component that it finished mounting *after* its children mount.
  defer {
    if needsDidMount {
      component.componentDidMount()
    }
  }
  
  incrementalContext.markMounted(layout: layout)
  
  guard let mountContext: MountContext = componentContext?.mountInfo.mountContext else {
    return
  }
  
  // The component may decide to reject mounting of its children if it wants to do so itself.
  if !mountContext.shouldMountChildren {
    return
  }
  
  let bounds = mountContext.view.bounds
  
  for childLayout in layout.children {
    let childFrame = CGRect(x: mountContext.position.x + childLayout.position.x,
                            y: mountContext.position.y + childLayout.position.y,
                            width: childLayout.layout.size.width,
                            height: childLayout.layout.size.height)
    if !mountVisibleOnly || childFrame.intersects(bounds) {
      // Recur into this layout's children if that child is visible. It's important that we do this even if the
      // component is already mounted, since some of their children may have been culled in a prior mounting pass.
      MountLayout(view: mountContext.view,
                  layout: childLayout.layout,
                  position: CGPoint(x: mountContext.position.x + childLayout.position.x,
                                    y: mountContext.position.y + childLayout.position.y),
                  incrementalContext: incrementalContext,
                  mountVisibleOnly: mountVisibleOnly)
    } else if mountVisibleOnly && incrementalContext.isMounted(layout: childLayout.layout) {
      UnmountLayout(layout: childLayout.layout, incrementalContext: incrementalContext)
    }
  }
}
