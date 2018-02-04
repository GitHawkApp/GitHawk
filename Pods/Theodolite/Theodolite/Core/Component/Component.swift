//
//  Component.swift
//  components-swift
//
//  Created by Oliver Rickard on 10/9/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

/**
 The superclass of all Components.

 This class provides the core, untyped API of Components. You subclass it, and override functions
 */
open class Component: UnTypedComponent {
  public required init(doNotCall key: AnyHashable?) {
    self.key = key
  }

  // MARK: Render

  /**
   Allows your component to render to an array of child components.

   This is the workhorse of React implementations. Ideally, your components just transform data in render() based on
   state and props, and then map to other components for view configuration, etc.

   NOTE: This can be called on any thread. This function must remain pure, or you will cause crashes.

   NOTE: Memoization is done by the framework automatically if your props are equatable, so instead of caching values
         in render, always prefer to implement equatable on your PropType, and leave it to the framework.
   */
  open func render() -> [Component] {
    return []
  }

  // MARK: Layout

  /**
   Computes the size and positioning of the component and its children.

   Allows components to specify how their children should be positioned relative to eachother. It's rare to need to
   do this, since generally you should just return a FlexboxComponent from render() to handle layout for you.

   @param constraint: The range of sizes that is allowed for your layout. NaN in any axis means unconstrained.
   @param tree: The result of the render() pass on every level of the component hierarchy. This gives you access to
                the children you created in render().

   @return A Layout object containing self, and the layouts of children.
   */
  open func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    return StandardLayout(component: self, constraint: constraint, tree: tree)
  }

  // MARK: Mount

  /**
   Mount: Attach your component to a view hierarchy.

   The normal algorithm can be found in StandardMountLayout().

   In general, you should not override these methods unless you're doing something really advanced. Instead, override
   the componentWillMount and related methods.

   @param parentView: The view you're mounting in. Not necessarily the view associated with your direct parent component
                      since not all components have views.
   @param layout: The layout object returned by your component in layout().
   @param position: The origin within the parentView's coordinate space for where you should render your component.

   @return A MountContext object, which provides the input parameters that should be used for your children. If you
           want your children to mount into a view you created, you should use that view for the mount context, and
           update the position for children to be within that view's coordinate space.
   */
  open func mount(parentView: UIView, layout: Layout, position: CGPoint) -> MountContext {
    return StandardMountLayout(parentView: parentView,
                               layout: layout,
                               position: position,
                               config: view(),
                               componentContext: self.context)
  }

  /**
   Unmount: Detach your component from the view hierarchy

   If you override this method, you **have to remember to check back in your view into the reuse pools**, or just call
   super.unmount(layout: layout) before returning.

   Generally, prefer to override componentWillUnmount() instead since it's much less tricky to get right.

   @param layout: The layout that was used to mount.
   */
  open func unmount(layout: Layout) {
    guard let config = self.view() else {
      return
    }
    let context = self.context
    guard let currentView = context.mountInfo.currentView else {
      return
    }

    context.mountInfo.currentView = nil;

    assert(currentView.superview != nil, "You must not remove a Theoodlite-managed view from the hierarchy")
    let superview = currentView.superview!

    let map = ViewPoolMap.getViewPoolMap(view: superview)
    map.checkinView(component: layout.component, parent: superview, config: config, view: currentView)
  }

  /** Called directly before mounting. */
  open func componentWillMount() {}
  /** Called after mounting the component itself, and its children. */
  open func componentDidMount() {
    if let view = self.context.mountInfo.currentView {
      // Hide any views that weren't vended from our view (not our parent's, that's their responsibility).
      ViewPoolMap.resetViewPoolMap(view: view)
    }
  }

  /** Called before unmounting the component or its children. */
  open func componentWillUnmount() {}

  /** Allows your component to state what type of view it should have, if any. */
  open func view() -> ViewConfiguration? {
    return nil
  }

  // MARK: Framework Details

  /**
   You probably shouldn't ever need to call this, but it provides information on the currently mounted view, and
   the last built layout.
   */
  public let context = ComponentContext()
  internal let key: AnyHashable?
}
