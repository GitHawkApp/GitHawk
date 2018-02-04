//
//  TextKitRenderer.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import UIKit
import CoreGraphics

public final class TextKitRenderer {
  internal let context: TextKitContext
  internal let attributes: TextKitAttributes
  internal let constrainedSize: CGSize
  
  public let size: CGSize
  
  init(attributes: TextKitAttributes,
       constrainedSize: CGSize) {
    self.attributes = attributes
    self.constrainedSize = constrainedSize
    
    self.context = TextKitContext(attributedString: attributes.attributedString,
                                  lineBreakMode: attributes.lineBreakMode,
                                  maximumNumberOfLines: attributes.maximumNumberOfLines,
                                  constrainedSize: constrainedSize)
    
    var boundingRect = CGRect.zero
    
    // Force glyph generation and layout, which may not have happened yet (and isn't triggered by
    // -usedRectForTextContainer:).
    context.withLock { (layoutManager, textStorage, textContainer) in
      layoutManager.ensureLayout(for: textContainer)
      boundingRect = layoutManager.usedRect(for: textContainer)
    }
    
    // TextKit often returns incorrect glyph bounding rects in the horizontal direction, so we clip to our bounding rect
    // to make sure our width calculations aren't being offset by glyphs going beyond the constrained rect.
    size = boundingRect.intersection(CGRect(origin: CGPoint.zero, size: constrainedSize)).size
  }
  
  public func drawInContext(graphicsContext: CGContext, bounds: CGRect) {
    graphicsContext.saveGState()
    UIGraphicsPushContext(graphicsContext)
    
    context.withLock { (layoutManager, textStorage, textContainer) in
      let glyphRange = layoutManager.glyphRange(forBoundingRect: bounds, in: textContainer)
      layoutManager.drawBackground(forGlyphRange: glyphRange, at: bounds.origin)
      layoutManager.drawGlyphs(forGlyphRange: glyphRange, at: bounds.origin)
    }
    
    UIGraphicsPopContext()
    graphicsContext.restoreGState()
  }
  
  // MARK: Caching
  
  static func renderer(attributes: TextKitAttributes, constrainedSize: CGSize) -> TextKitRenderer {
    let key = TextKitRendererKey(attributes: attributes, constrainedSize: constrainedSize)
    if let renderer = gTextKitRendererCache.object(forKey: key) {
      return renderer
    }
    
    let renderer = TextKitRenderer(attributes: attributes, constrainedSize: constrainedSize)
    gTextKitRendererCache.setObject(renderer, forKey: key)
    return renderer
  }

  /** TODO: Replace this with a cache, but NSCache appears not to call hashValue? */
  static var gTextKitRendererCache: TextCache<TextKitRendererKey, TextKitRenderer> = {
    let cache = TextCache<TextKitRendererKey, TextKitRenderer>()
    cache.countLimit = 100
    cache.name = "Theodolite-TextKitRendererCache"
    return cache
  }()
}

internal class TextKitRendererKey: Equatable, Hashable {
  let attributes: TextKitAttributes
  let constrainedSize: CGSize

  private let hash: Int
  
  init(attributes: TextKitAttributes,
       constrainedSize: CGSize) {
    self.attributes = attributes
    self.constrainedSize = constrainedSize
    hash = HashArray([
      attributes,
      ceil(constrainedSize.width),
      ceil(constrainedSize.height),
      ])
  }
  
  public static func ==(lhs: TextKitRendererKey, rhs: TextKitRendererKey) -> Bool {
    return lhs.attributes == rhs.attributes
      && SizesEqual(lhs.constrainedSize, rhs.constrainedSize)
  }
  
  public var hashValue: Int {
    return hash
  }
}
