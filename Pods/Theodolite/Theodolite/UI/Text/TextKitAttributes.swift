//
//  TextKitAttributes.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

/**
 All NSObject values in this struct should be copied when passed into the TextComponent.
 */
public struct TextKitAttributes: Equatable, Hashable {
  /**
   The string to be drawn.  CKTextKit will not augment this string with default colors, etc. so this must be complete.
   */
  let attributedString: NSAttributedString
  /**
   The line-break mode to apply to the text.  Since this also impacts how TextKit will attempt to truncate the text
   in your string, we only support NSLineBreakByWordWrapping and NSLineBreakByCharWrapping.
   */
  let lineBreakMode: NSLineBreakMode
  /**
   The maximum number of lines to draw in the drawable region.  Leave blank or set to 0 to define no maximum.
   */
  let maximumNumberOfLines: Int

  init(attributedString: NSAttributedString,
       lineBreakMode: NSLineBreakMode = NSLineBreakMode.byTruncatingTail,
       maximumNumberOfLines: Int = 1) {
    self.attributedString = attributedString
    self.lineBreakMode = lineBreakMode
    self.maximumNumberOfLines = maximumNumberOfLines
  }
  
  public static func ==(lhs: TextKitAttributes, rhs: TextKitAttributes) -> Bool {
    return lhs.lineBreakMode == rhs.lineBreakMode
      && lhs.maximumNumberOfLines == rhs.maximumNumberOfLines
      && lhs.attributedString == rhs.attributedString
  }
  
  public var hashValue: Int {
    let hash = HashArray([
        attributedString,
        lineBreakMode,
        maximumNumberOfLines,
      ])
    return hash
  }
};
