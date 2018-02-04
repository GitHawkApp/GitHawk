//
//  LabelComponent.swift
//  TheodoliteFeed
//
//  Created by Oliver Rickard on 10/13/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

public final class LabelComponent: Component, TypedComponent {
  public struct Options {
    let view: ViewOptions
    let font: UIFont
    let textColor: UIColor
    let textAlignment: NSTextAlignment
    let lineBreakMode: NSLineBreakMode
    let maximumNumberOfLines: Int
    
    public init(
      view: ViewOptions = ViewOptions(),
      font: UIFont = UIFont.systemFont(ofSize: UIFont.systemFontSize),
      textColor: UIColor = UIColor.black,
      textAlignment: NSTextAlignment = .natural,
      lineBreakMode: NSLineBreakMode = .byTruncatingTail,
      maximumNumberOfLines: Int = 1) {
      self.view = view
      self.font = font
      self.textColor = textColor
      self.textAlignment = textAlignment
      self.lineBreakMode = lineBreakMode
      self.maximumNumberOfLines = maximumNumberOfLines
    }
  }
  
  public typealias PropType = (
    String,
    options: Options
  )
  
  func attributes(props: PropType) -> Dictionary<NSAttributedStringKey, Any> {
    var attr: Dictionary<NSAttributedStringKey, Any> = [:]
    attr[NSAttributedStringKey.font] = props.options.font
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = props.options.lineBreakMode
    paragraphStyle.alignment = props.options.textAlignment
    attr[NSAttributedStringKey.paragraphStyle] = paragraphStyle
    attr[NSAttributedStringKey.foregroundColor] = props.options.textColor
    return attr
  }
  
  func attributedString(props: PropType) -> NSAttributedString {
    return NSAttributedString.init(string: props.0,
                                   attributes: self.attributes(props: props))
  }
  
  public override func render() -> [Component] {
    let props = self.props
    return [
      TextComponent(
        (TextKitAttributes(
          attributedString: self.attributedString(props:props),
          lineBreakMode: props.options.lineBreakMode,
          maximumNumberOfLines: props.options.maximumNumberOfLines
          ),
         options: TextComponent.Options(
          view: props.options.view
        ))
      )
    ]
  }
}
