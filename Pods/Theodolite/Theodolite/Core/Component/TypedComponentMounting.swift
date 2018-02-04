//
//  TypedComponentMounting.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/25/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public  func StandardMountLayout(parentView: UIView,
                                  layout: Layout,
                                  position: CGPoint,
                                  config: ViewConfiguration?,
                                  componentContext: ComponentContext) -> MountContext {
  guard let config = config else {
    return MountContext(view: parentView,
                        position: position,
                        shouldMountChildren: true)
  }
  
  let map = ViewPoolMap.getViewPoolMap(view: parentView)
  let view = map
    .checkoutView(component: layout.component, parent: parentView, config: config)!
  componentContext.mountInfo.currentView = view
  view.frame = CGRect(x: position.x,
                      y: position.y,
                      width: layout.size.width,
                      height: layout.size.height)
  
  return MountContext(view: view,
                      position: CGPoint(x: 0, y: 0),
                      shouldMountChildren: true)
}
