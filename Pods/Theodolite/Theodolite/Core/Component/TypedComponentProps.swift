//
//  TypedComponentProps.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/25/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

public extension TypedComponent {
  var props: PropType {
    get {
      return context.props as! PropType
    }
  }
}
