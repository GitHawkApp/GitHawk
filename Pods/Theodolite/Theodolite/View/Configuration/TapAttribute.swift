//
//  TapAttribute.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/28/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

internal class TapToken: Equatable {}

internal func ==(lhs: TapToken, rhs: TapToken) -> Bool {
  return lhs === rhs
}

public class TapAttribute: Attribute {
  private var gesture: UITapGestureRecognizer? = nil
  private var target: TapTarget
  
  public init(_ action: Action<UITapGestureRecognizer>) {
    self.target = TapTarget({ (gesture: UITapGestureRecognizer) in
      action.send(gesture)
    })
    super.init()
    self.identifier = "theodolite-tapAttribute"
    self.value = AttributeValue(TapToken())
  }
  
  override func apply(view: UIView) {
    if let gesture = self.gesture {
      gesture.view?.removeGestureRecognizer(gesture)
      view.addGestureRecognizer(gesture)
    } else {
      let gesture = UITapGestureRecognizer(target: target, action: #selector(TapTarget.actionMethod(sender:)))
      view.addGestureRecognizer(gesture)
      self.gesture = gesture
    }
  }
  
  override func unapply(view: UIView) {
    if let gesture = self.gesture {
      view.removeGestureRecognizer(gesture)
    }
  }
}

@objc class TapTarget: NSObject {
  let handler: (UITapGestureRecognizer) -> ()
  
  init(_ handler: @escaping (UITapGestureRecognizer) -> ()) {
    self.handler = handler
    super.init()
  }
  
  @objc internal func actionMethod(sender: UITapGestureRecognizer) {
    handler(sender)
  }
}
