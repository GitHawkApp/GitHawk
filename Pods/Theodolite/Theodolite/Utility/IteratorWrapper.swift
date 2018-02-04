//
//  IteratorWrapper.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/23/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

/**
 Internal iterator struct (probably unnecessary) to make the view reuse algorithm look identical to the C++ version
 in ComponentKit.
 
 TODO: Remove this, and Swiftify the reuse algorithm now that this is tested.
 */
struct IteratorWrapper<T: AnyObject> {
  private var array: Array<T>
  
  var current: T? = nil
  var offset: Int = 0
  
  init(_ array: Array<T>,
       initialOffset: Int = 0) {
    self.array = array
    offset = initialOffset
    if initialOffset < array.count {
      current = array[initialOffset]
    }
  }
  
  func find(_ val: T) -> Int? {
    for i in offset ..< array.count {
      let v = array[i]
      if v === val {
        return i
      }
    }
    return nil
  }
  
  mutating func advance() {
    if offset + 1 < array.count {
      offset += 1
      current = array[offset]
    } else {
      current = nil
      offset += 0
    }
  }
}
