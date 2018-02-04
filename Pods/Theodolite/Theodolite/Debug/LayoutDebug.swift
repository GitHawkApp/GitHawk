//
//  LayoutDebug.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/24/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

extension Layout: CustomStringConvertible
{
  public var description: String
  {
    return _descriptionForDepth(0)
  }
  
  private func _descriptionForDepth(_ depth: Int) -> String
  {
    let selfDescription = "[\(String(describing: component))] {size={\(size.width), \(size.height)}}"
    if children.isEmpty {
      return selfDescription
    }
    else {
      let indentation = (0...depth).reduce("\n") { accum, _ in accum + "\t" }
      let childrenDescription = (children.map {
        "{position={\($0.position.x), \($0.position.y)}}"
          + $0.layout._descriptionForDepth(depth + 1)
      }).joined(separator: indentation)
      return "\(selfDescription)\(indentation)\(childrenDescription)"
    }
  }
}
