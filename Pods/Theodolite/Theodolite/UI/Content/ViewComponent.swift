//
//  ViewComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/31/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public final class ViewComponent: Component, TypedComponent {
  public typealias PropType = ViewConfiguration

  public override func view() -> ViewConfiguration? {
    return self.props
  }

  public override func layout(constraint: SizeRange, tree: ComponentTree) -> Layout {
    return Layout(component: self,
                  size: constraint.max,
                  children: [])
  }
}
