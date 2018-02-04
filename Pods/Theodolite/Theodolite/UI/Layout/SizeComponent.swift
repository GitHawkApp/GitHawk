//
//  SizeComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/31/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public final class SizeComponent: Component, TypedComponent {
  public typealias PropType = (
    size: CGSize,
    component: Component
  )

  public override func render() -> [Component] {
    return [self.props.component]
  }

  public override func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    let size = self.props.size
    let childTree = tree.children()[0]
    let childLayout = childTree
      .component()
      .layout(
        constraint:
        SizeRange(
          min: size,
          max: size
        ),
        tree: childTree)
    return Layout(
      component: self,
      size: constraint.clamp(childLayout.size),
      children: [
        LayoutChild(
          layout: childLayout,
          position: CGPoint.zero)
      ])
  }
}
