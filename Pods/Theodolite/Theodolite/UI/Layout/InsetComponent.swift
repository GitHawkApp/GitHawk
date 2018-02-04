//
//  InsetComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/28/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public final class InsetComponent: Component, TypedComponent {
  public typealias PropType = (
    insets: UIEdgeInsets,
    component: Component
  )
  
  public override func render() -> [Component] {
    return [self.props.component]
  }
  
  public override func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    let insets = self.props.insets
    let childTree = tree.children()[0]
    let childLayout = childTree
      .component()
      .layout(
        constraint:
        SizeRange(
          min: insetSize(constraint: constraint.min, insets: insets),
          max: insetSize(constraint: constraint.max, insets: insets)
        ),
        tree: childTree)
    return Layout(
      component: self,
      size: constraint.clamp(
        CGSize(width: childLayout.size.width + insets.left + insets.right,
               height: childLayout.size.height + insets.top + insets.bottom)),
      children: [
        LayoutChild(
          layout: childLayout,
          position: CGPoint(x: insets.left, y: insets.top))
      ])
  }
  
  private func insetSize(constraint: CGSize, insets: UIEdgeInsets) -> CGSize {
    return CGSize(
      width: constraint.width.isNaN
        ? CGFloat.nan
        : max(constraint.width - insets.left - insets.right, 0),
      height: constraint.height.isNaN
        ? CGFloat.nan
        : max(constraint.height - insets.top - insets.bottom, 0))
  }
}
