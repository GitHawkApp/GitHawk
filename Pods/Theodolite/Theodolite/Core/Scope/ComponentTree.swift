//
//  ComponentTree.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/13/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public protocol ComponentTree: class {
  func component() -> Component
  func children() -> [ComponentTree]
}
