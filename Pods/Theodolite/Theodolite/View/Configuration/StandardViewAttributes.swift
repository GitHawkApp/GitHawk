//
//  StandardViewAttributes.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/14/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

/**
 A utility struct that can be exposed as props for a component that renders a view
 to provide simple configuration of most common UIView parameters.
 */
public struct ViewOptions {
  let backgroundColor: UIColor?
  let tintColor: UIColor?
  
  let isMultipleTouchEnabled: Bool?
  let isExclusiveTouchEnabled: Bool?
  
  let clipsToBounds: Bool?
  
  let alpha: CGFloat?
  
  let contentMode: UIViewContentMode?

  let isAccessibilityElement: Bool?
  let accessibilityLabel: String?

  let layerOptions: LayerOptions?
  
  public init(backgroundColor: UIColor? = nil,
              tintColor: UIColor? = nil,
              isMultipleTouchEnabled: Bool? = nil,
              isExclusiveTouchEnabled: Bool? = nil,
              clipsToBounds: Bool? = nil,
              alpha: CGFloat? = nil,
              contentMode: UIViewContentMode? = nil,
              isAccessibilityElement: Bool? = nil,
              accessibilityLabel: String? = nil,
              layerOptions: LayerOptions? = nil) {
    self.backgroundColor = backgroundColor
    self.tintColor = tintColor
    self.isMultipleTouchEnabled = isMultipleTouchEnabled
    self.isExclusiveTouchEnabled = isExclusiveTouchEnabled
    self.clipsToBounds = clipsToBounds
    self.alpha = alpha
    self.contentMode = contentMode
    self.isAccessibilityElement = isAccessibilityElement
    self.accessibilityLabel = accessibilityLabel
    self.layerOptions = layerOptions
  }
  
  public func viewAttributes() -> [Attribute] {
    var attrs: [Attribute] = []
    if let color = self.backgroundColor {
      attrs.append(ViewBackgroundColor(color))
    }
    if let color = self.tintColor {
      attrs.append(ViewTintColor(color))
    }
    if let isMultipleTouchEnabled = self.isMultipleTouchEnabled {
      attrs.append(ViewIsMultipleTouchEnabled(isMultipleTouchEnabled))
    }
    if let isExclusiveTouchEnabled = self.isExclusiveTouchEnabled {
      attrs.append(ViewIsExclusiveTouchEnabled(isExclusiveTouchEnabled))
    }
    if let clipsToBounds = self.clipsToBounds {
      attrs.append(ViewClipsToBounds(clipsToBounds))
    }
    if let alpha = self.alpha {
      attrs.append(ViewAlpha(alpha))
    }
    if let contentMode = self.contentMode {
      attrs.append(ViewContentMode(contentMode))
    }
    if let isAccessibilityElement = self.isAccessibilityElement {
      attrs.append(ViewIsAccessibilityElement(isAccessibilityElement))
    }
    if let accessibilityLabel = self.accessibilityLabel {
      attrs.append(ViewAccessibilityLabel(accessibilityLabel))
    }
    if let layerOptions = self.layerOptions {
      attrs.append(contentsOf: layerOptions.viewAttributes())
    }
    return attrs
  }
}

public func ViewBackgroundColor(_ color: UIColor) -> Attribute {
  return Attr<UIView, UIColor>(color, identifier: "theodolite-setBackgroundColor") {(view: UIView, val: UIColor) in
    view.backgroundColor = val;
  }
}

public func ViewTintColor(_ color: UIColor) -> Attribute {
  return Attr<UIView, UIColor>(color, identifier: "theodolite-setTintColor") {(view: UIView, val: UIColor) in
    view.tintColor = val;
  }
}

public func ViewIsMultipleTouchEnabled(_ enabled: Bool) -> Attribute {
  return Attr<UIView, Bool>(enabled, identifier: "theodolite-setIsMultipleTouchEnabled") {(view: UIView, val: Bool) in
    view.isMultipleTouchEnabled = val;
  }
}

public func ViewIsExclusiveTouchEnabled(_ enabled: Bool) -> Attribute {
  return Attr<UIView, Bool>(enabled, identifier: "theodolite-setIsExclusiveTouchEnabled") {(view: UIView, val: Bool) in
    view.isExclusiveTouch = val;
  }
}

public func ViewClipsToBounds(_ enabled: Bool) -> Attribute {
  return Attr<UIView, Bool>(enabled, identifier: "theodolite-setClipsToBounds") {(view: UIView, val: Bool) in
    view.clipsToBounds = val;
  }
}

public func ViewAlpha(_ enabled: CGFloat) -> Attribute {
  return Attr<UIView, CGFloat>(enabled, identifier: "theodolite-setAlpha") {(view: UIView, val: CGFloat) in
    view.alpha = val;
  }
}

public func ViewContentMode(_ enabled: UIViewContentMode) -> Attribute {
  return Attr<UIView, UIViewContentMode>(enabled, identifier: "theodolite-setContentMode") {(view: UIView, val: UIViewContentMode) in
    view.contentMode = val;
  }
}

public func ViewIsAccessibilityElement(_ enabled: Bool) -> Attribute {
  return Attr<UIView, Bool>(enabled, identifier: "theodolite-setIsAccessibilityElement") {(view: UIView, val: Bool) in
    view.isAccessibilityElement = val;
  }
}

public func ViewAccessibilityLabel(_ label: String) -> Attribute {
  return Attr<UIView, String>(label, identifier: "theodolite-setAccessibilityLabel") {(view: UIView, val: String) in
    view.accessibilityLabel = val;
  }
}

public struct LayerOptions {
  let cornerRadius: CGFloat?

  let borderWidth: CGFloat?
  let borderColor: UIColor?

  let shadowColor: UIColor?
  let shadowOpacity: Float?
  let shadowOffset: CGSize?
  let shadowRadius: CGFloat?

  public init(cornerRadius: CGFloat? = nil,
              borderWidth: CGFloat? = nil,
              borderColor: UIColor? = nil,
              shadowColor: UIColor? = nil,
              shadowOpacity: Float? = nil,
              shadowOffset: CGSize? = nil,
              shadowRadius: CGFloat? = nil) {
    self.cornerRadius = cornerRadius
    self.borderWidth = borderWidth
    self.borderColor = borderColor
    self.shadowColor = shadowColor
    self.shadowOpacity = shadowOpacity
    self.shadowOffset = shadowOffset
    self.shadowRadius = shadowRadius
  }

  public func viewAttributes() -> [Attribute] {
    var attrs: [Attribute] = []
    if let cornerRadius = self.cornerRadius {
      attrs.append(LayerCornerRadius(cornerRadius))
    }
    if let borderWidth = self.borderWidth {
      attrs.append(LayerBorderWidth(borderWidth))
    }
    if let borderColor = self.borderColor {
      attrs.append(LayerBorderColor(borderColor))
    }
    if let shadowColor = self.shadowColor {
      attrs.append(LayerShadowColor(shadowColor))
    }
    if let shadowOpacity = self.shadowOpacity {
      attrs.append(LayerShadowOpacity(shadowOpacity))
    }
    if let shadowOffset = self.shadowOffset {
      attrs.append(LayerShadowOffset(shadowOffset))
    }
    if let shadowRadius = self.shadowRadius {
      attrs.append(LayerShadowRadius(shadowRadius))
    }
    return attrs
  }
}

public func LayerCornerRadius(_ radius: CGFloat) -> Attribute {
  return Attr<UIView, CGFloat>(radius, identifier: "theodolite-layer-cornerRadius") {(view: UIView, val: CGFloat) in
    view.layer.cornerRadius = val
  }
}

public func LayerBorderWidth(_ width: CGFloat) -> Attribute {
  return Attr<UIView, CGFloat>(width, identifier: "theodolite-layer-borderWidth") {(view: UIView, val: CGFloat) in
    view.layer.borderWidth = val
  }
}

public func LayerBorderColor(_ color: UIColor) -> Attribute {
  return Attr<UIView, UIColor>(color, identifier: "theodolite-layer-borderColor") {(view: UIView, val: UIColor) in
    view.layer.borderColor = val.cgColor
  }
}

public func LayerShadowColor(_ color: UIColor) -> Attribute {
  return Attr<UIView, UIColor>(color, identifier: "theodolite-layer-shadowColor") {(view: UIView, val: UIColor) in
    view.layer.shadowColor = val.cgColor
  }
}

public func LayerShadowOpacity(_ opacity: Float) -> Attribute {
  return Attr<UIView, Float>(opacity, identifier: "theodolite-layer-shadowOpacity") {(view: UIView, val: Float) in
    view.layer.shadowOpacity = val
  }
}

public func LayerShadowOffset(_ offset: CGSize) -> Attribute {
  return Attr<UIView, CGSize>(offset, identifier: "theodolite-layer-shadowOffset") {(view: UIView, val: CGSize) in
    view.layer.shadowOffset = val
  }
}

public func LayerShadowRadius(_ radius: CGFloat) -> Attribute {
  return Attr<UIView, CGFloat>(radius, identifier: "theodolite-layer-shadowRadius") {(view: UIView, val: CGFloat) in
    view.layer.shadowRadius = val
  }
}
