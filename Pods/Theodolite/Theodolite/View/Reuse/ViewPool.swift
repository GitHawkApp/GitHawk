//
//  ViewPool.swift
//  components-swift
//
//  Created by Oliver Rickard on 10/9/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

/**
 Internal view pool. Holds a list of views that Theodolite has constructed, and is responsible for keeping track
 of which views are vended out of its list, and is responsible for hiding any views that haven't been vended in
 any particular mount cycle.
 */
public class ViewPool {
  private struct View {
    let view: UIView
    var identifier: ScopeIdentifier
  }

  private var views: [View] = []
  
  func reset() {
    for view in views {
      if !view.view.isHidden {
        view.view.isHidden = true
      }
    }
  }
  
  func checkoutView(component: Component, parent: UIView, config: ViewConfiguration) -> UIView? {
    let applyView = { (view: UIView) -> UIView in
      if view.isHidden {
        view.isHidden = false
      }
      config.applyToView(v: view)
      return view
    }

    let scopeHandleIdentifier = getIdentifier(component: component)

    // First search for a view that exactly matches this component, if we can find one. This is to avoid re-shuffling
    // views unless we absolutely have to if the component was previously mounted.
    for i in 0 ..< views.count {
      let v = views[i]
      if scopeHandleIdentifier == v.identifier {
        views.remove(at: i)
        return applyView(v.view)
      }
    }

    if let view = views.first {
      views.removeFirst()
      return applyView(view.view)
    }
    let newView = config.buildView()
    parent.addSubview(newView)
    return newView
  }
  
  func checkinView(component: Component, view: UIView) {
    views.append(View(view: view, identifier: getIdentifier(component: component)))
    if views.count > 100 {
      print("View pool is too big for the linear algorithms.")
    }
  }

  func getIdentifier(component: Component) -> ScopeIdentifier {
    return getScopeHandle(component: component)?.identifier ?? ScopeIdentifier(path:[])
  }
}
