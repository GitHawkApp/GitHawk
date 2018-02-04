//
//  ActivityIndicatorComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 11/19/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public final class ActivityIndicatorComponent: Component, TypedComponent {
  public typealias PropType = Void?

  public override func view() -> ViewConfiguration? {
    return ViewConfiguration(view: UIActivityIndicatorView.self, attributes: [])
  }

  public override func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    return Layout(component: self,
                  size: constraint.clamp(
                    CGSize(
                      width: 60,
                      height: 60)),
                  children: [])
  }

  public override func componentDidMount() {
    super.componentDidMount()
    guard let activityIndicator = context.mountInfo.currentView as? UIActivityIndicatorView else {
      return
    }
    activityIndicator.startAnimating()
  }

  public override func componentWillUnmount() {
    super.componentWillUnmount()
    guard let activityIndicator = context.mountInfo.currentView as? UIActivityIndicatorView else {
      return
    }
    activityIndicator.stopAnimating()
  }
}
