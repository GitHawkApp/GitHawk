//
//  TapComponent.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/28/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public final class TapComponent: Component, TypedComponent {
  public typealias PropType = (
    action: Action<UITapGestureRecognizer>,
    component: Component
  )
  
  public override func render() -> [Component] {
    return [self.props.component]
  }
  
  public override func view() -> ViewConfiguration? {
    return ViewConfiguration(
      view: UIView.self,
      attributes: [
        TapAttribute(self.props.action)
      ])
  }
}
