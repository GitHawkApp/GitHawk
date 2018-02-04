//
//  TextKitLayer.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/31/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit

private class TextKitDrawParameters: NSObject {
  let attributes: TextKitAttributes
  init(attributes: TextKitAttributes) {
    self.attributes = attributes
  }
}

public final class TextKitLayer: TheodoliteAsyncLayer {
  var attributes: TextKitAttributes? = nil {
    didSet {
      if attributes != oldValue {
        self.setNeedsDisplay()
      }
    }
  }

  public override init() {
    super.init()
    #if DEBUG
      if let _ = NSClassFromString("XCTest") {
        // While tests are running, we need to ensure we display synchronously
        self.displayMode = .alwaysSync
      } else {
        self.displayMode = .alwaysAsync
      }
    #else
      self.displayMode = .alwaysAsync
    #endif
  }

  public override var needsDisplayOnBoundsChange: Bool {
    get {
      return true
    }
    set {
      // Don't allow this property to be disabled.  Unfortunately, UIView will turn this off when setting the
      // backgroundColor, for reasons that cannot be understood.  Even worse, it doesn't ever set it back, so it will
      // subsequently stay off.  Just make sure that it never gets overridden, because the text will not be drawn in the
      // correct way (or even at all) if this is set to NO.
    }
  }

  public override init(layer: Any) {
    super.init(layer: layer)
  }

  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public override class func defaultValue(forKey key: String) -> Any? {
    switch key {
    case "contentsScale":
      return NSNumber(value: Double(TextKitLayer.gScreenScale))
    default:
      return super.defaultValue(forKey: key)
    }
  }

  public override func drawParameters() -> NSObject! {
    guard let attributes = self.attributes else {
      return NSObject()
    }
    return TextKitDrawParameters(attributes: attributes)
  }

  public override func draw(in ctx: CGContext) {
    if self.isOpaque, let bgColor = self.backgroundColor {
      ctx.saveGState()
      let boundsRect = ctx.boundingBoxOfClipPath
      ctx.setFillColor(bgColor)
      ctx.fill(boundsRect)
      ctx.restoreGState()
    }
    super.draw(in: ctx)
  }

  public override class func draw(in ctx: CGContext, parameters: NSObject) {
    guard let params = parameters as? TextKitDrawParameters else {
      return
    }
    let rect = ctx.boundingBoxOfClipPath
    let renderer = TextKitRenderer.renderer(attributes: params.attributes,
                                            constrainedSize: rect.size)
    renderer.drawInContext(graphicsContext: ctx,
                           bounds: rect)
  }

  public override func didDisplayAsynchronously(_ newContents: Any?, withDrawParameters drawParameters: NSObjectProtocol) {
    guard newContents != nil else {
      return
    }
    let image = newContents as! CGImage
    let bytes = image.bytesPerRow * image.height
    TextKitLayer
      .gTextKitRenderArtifactCache
      .setObject(image,
                 forKey: TextKitRendererKey(
                  attributes: self.attributes!,
                  constrainedSize: self.bounds.size),
                 cost: bytes)
  }

  public override func willDisplayAsynchronously(withDrawParameters drawParameters: NSObjectProtocol) -> Any? {
    let cached = TextKitLayer
    .gTextKitRenderArtifactCache
      .object(forKey: TextKitRendererKey(
        attributes: self.attributes!,
        constrainedSize: self.bounds.size))
    return cached
  }

  static var gTextKitRenderArtifactCache: TextCache<TextKitRendererKey, AnyObject> = {
    let cache = TextCache<TextKitRendererKey, AnyObject>()
    cache.totalCostLimit = 6 * 1024 * 1024
    return cache
  }()

  static var gScreenScale: CGFloat = UIScreen.main.scale
}


