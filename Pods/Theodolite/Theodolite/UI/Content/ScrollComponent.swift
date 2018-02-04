//
//  ScrollComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/26/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public final class ScrollComponent: Component, TypedComponent, ScrollListener {
  public typealias PropType = (
    Component,
    direction: UICollectionViewScrollDirection,
    attributes: [Attribute]
  )
  public class State {
    var contentOffset = CGPoint.zero
  }
  public typealias StateType = State
  
  private var scrollDelegate: InternalScrollDelegate? = nil
  private var mountedArguments: (parentView: UIView, layout: WeakContainer<Layout>, position: CGPoint)? = nil
  private var incrementalMountContext: IncrementalMountContext = IncrementalMountContext()

  public func initialState() -> ScrollComponent.State? {
    return State()
  }
  
  public override func render() -> [Component] {
    return [self.props.0]
  }
  
  public override func view() -> ViewConfiguration? {
    return ViewConfiguration(view: UIScrollView.self,
                             attributes: self.props.attributes)
  }
  
  public override func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    let direction = self.props.direction
    let children = tree.children().map { (childTree: ComponentTree) -> LayoutChild in
      return LayoutChild(
        layout:childTree
          .component()
          .layout(constraint:
            SizeRange(max:
              direction == UICollectionViewScrollDirection.vertical
                ? CGSize(width: constraint.max.width,
                         height: nan("unconstrained"))
                : CGSize(width: nan("unconstrained"),
                         height: constraint.max.height)),
                  tree: childTree),
        position: CGPoint(x: 0, y: 0))
    }
    
    let contentRect = children.reduce(
      CGRect(x: 0, y: 0, width: 0, height: 0),
      { (unionRect, layoutChild) -> CGRect in
        return unionRect.union(CGRect(origin: layoutChild.position,
                                      size: layoutChild.layout.size))
    })
    
    return Layout(
      component: self,
      size: direction == UICollectionViewScrollDirection.vertical
        ? CGSize(width: contentRect.size.width, height: constraint.max.height)
        : CGSize(width: constraint.max.width, height: contentRect.size.height),
      children: children,
      extra: contentRect.size)
  }
  
  public override func mount(parentView: UIView,
                    layout: Layout,
                    position: CGPoint) -> MountContext {
    mountedArguments = (parentView: parentView, layout: WeakContainer(layout), position: position)
    
    let componentContext = context
    
    let mountContext = StandardMountLayout(parentView: parentView,
                                           layout: layout,
                                           position: position,
                                           config: self.view(),
                                           componentContext: componentContext)
    
    let scrollView = mountContext.view as! UIScrollView
    scrollDelegate = InternalScrollDelegate(layout: layout)
    let contentSize = layout.extra as! CGSize
    if scrollView.contentSize != contentSize {
      scrollView.contentSize = contentSize
    }
    let contentOffset = state!.contentOffset
    if scrollView.contentOffset != contentOffset {
      scrollView.contentOffset = state!.contentOffset
    }
    
    // Now we mount our children
    // todo: this is terrible, need to fix it
    componentContext.mountInfo.mountContext = mountContext
    mountChildren(componentContext)

    // Mounting children and setting content size can call into scrollViewDidScroll, which will cause us to mount
    // Don't set ourselves as the delegate until it's ready.
    scrollView.delegate = scrollDelegate
    
    return MountContext(view: mountContext.view,
                        position: mountContext.position,
                        shouldMountChildren: false)
  }
  
  public override func componentWillUnmount() {
    super.componentWillUnmount()
    let scrollView = context.mountInfo.currentView as? UIScrollView
    scrollView?.delegate = nil
    
    guard let mountedArguments = mountedArguments else {
      assertionFailure()
      return
    }
    UnmountLayout(layout: mountedArguments.layout.val!.children[0].layout,
                  incrementalContext: incrementalMountContext)
  }
  
  private func mountChildren(_ componentContext: ComponentContext) {
    guard let mountedArguments = mountedArguments else {
      assertionFailure()
      return
    }
    MountRootLayout(view: componentContext.mountInfo.mountContext!.view,
                    layout: mountedArguments.layout.val!.children[0].layout,
                    position: componentContext.mountInfo.mountContext!.position,
                    incrementalContext: incrementalMountContext,
                    mountVisibleOnly: true)
  }
  
  // MARK: ScrollListener
  
  public func scrollViewDidScroll(scrollView: UIScrollView) {
    state!.contentOffset = scrollView.contentOffset
    mountChildren(context)
  }
}

private protocol ScrollListener: AnyObject {
  func scrollViewDidScroll(scrollView: UIScrollView)
}

@objc private class InternalScrollDelegate: NSObject, UIScrollViewDelegate {
  weak var layout: Layout?
  
  init(layout: Layout) {
    self.layout = layout
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let layout = self.layout else {
      return
    }
    announce(layout: layout) { (listener: ScrollListener) in
      listener.scrollViewDidScroll(scrollView: scrollView)
    }
  }
  
  private func announce(layout: Layout, closure: (ScrollListener) -> ()) {
    if let listener = layout.component as? ScrollListener {
      closure(listener)
    }
    // TODO: see if we should traverse
  }
}
