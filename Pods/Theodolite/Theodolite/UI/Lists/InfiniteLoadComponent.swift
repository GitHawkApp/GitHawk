//
//  InfiniteLoadComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 11/19/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public final class InfiniteLoadComponent: Component, TypedComponent {
  public typealias PropType = (
    flexOptions: FlexOptions,
    loadMoreAction: Action<Void?>,
    component: Component
  )

  private var observation: NSKeyValueObservation? = nil
  private var sentAction: Bool = false
  private var contentSize: CGSize = CGSize.zero

  public override func render() -> [Component] {
    return [
      FlexboxComponent(
        (options: props.flexOptions,
         children: [
          FlexChild(props.component),
          FlexChild(ActivityIndicatorComponent( nil ))
          ])
      )
    ]
  }

  public override func componentDidMount() {
    super.componentDidMount()

    var parent: UIView? = self.context.mountInfo.mountContext?.view
    while parent != nil && !(parent?.isKind(of: UIScrollView.self) ?? false) {
      parent = parent?.superview
    }

    guard let scrollView = parent as? UIScrollView else {
      assertionFailure("Infinite load to refresh component isn't in a scroll view")
      return
    }

    assert(observation == nil)
    observation = scrollView.observe(\.contentOffset) { [weak self] (scrollView, change) in
      self?.checkIfNearEnd(scrollView: scrollView)
    }
  }

  private func checkIfNearEnd(scrollView: UIScrollView) {
    if sentAction {
      return
    }

    // Figure out which direction the scroll view scrolls
    let contentSize = scrollView.contentSize
    let bounds = scrollView.bounds

    if bounds.width < contentSize.width {
      // We're scrolling in the X direction
      if bounds.maxX > contentSize.width - 200 {
        sentAction = true
        props.loadMoreAction.send(nil)
      }
    }

    if bounds.height < contentSize.height && !sentAction {
      // We're scrolling in the Y direction, and we didn't just send the action for the X direction
      if bounds.maxY > contentSize.height - 200 {
        sentAction = true
        props.loadMoreAction.send(nil)
      }
    }
  }
}
