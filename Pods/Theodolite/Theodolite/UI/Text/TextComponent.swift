//
//  TextComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public final class TextComponent: Component, TypedComponent {
  public typealias PropType = (
    TextKitAttributes,
    options: Options
  )
  
  public struct Options {
    let view: ViewOptions
    init(view: ViewOptions = ViewOptions()) {
      self.view = view
    }
  }
  
  public override func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    let renderer = TextKitRenderer.renderer(attributes: self.props.0,
                                            constrainedSize: reinterpretSize(size: constraint.max))
    return Layout(component: self,
                  size: constraint.clamp(
                    CGSize(
                      width: ceil(renderer.size.width),
                      height: ceil(renderer.size.height))),
                  children: [])
  }
  
  private func reinterpretSize(size: CGSize) -> CGSize {
    return CGSize(
      width: size.width.isNaN ? CGFloat.greatestFiniteMagnitude : size.width,
      height: size.height.isNaN ? CGFloat.greatestFiniteMagnitude : size.height
    )
  }
  
  public override func view() -> ViewConfiguration? {
    var attributes = self.props.options.view.viewAttributes()
    
    attributes.append(Attr(self.props.0, identifier: "theodolite-TextKitAttributes")
    {(view: TextKitView, attributes: TextKitAttributes) in
      view.attributes = attributes})
    
    return ViewConfiguration(
      view: TextKitView.self,
      attributes: attributes)
  }
}
