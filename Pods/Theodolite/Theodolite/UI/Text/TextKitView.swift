//
//  TextKitView.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public  final class TextKitView: UIView {
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.backgroundColor = UIColor.clear
    self.contentScaleFactor = TextKitLayer.gScreenScale;
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var attributes: TextKitAttributes? = nil {
    didSet {
      if attributes != oldValue {
        (self.layer as! TextKitLayer).attributes = attributes
      }
    }
  }

  override public class var layerClass: Swift.AnyClass {
    return TextKitLayer.self
  }
}
