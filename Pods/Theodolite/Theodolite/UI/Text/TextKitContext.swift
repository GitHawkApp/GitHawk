//
//  TextKitContext.swift
//  Theodolite
//
//  Created by Oliver Rickard on 10/29/17.
//  Copyright © 2017 Oliver Rickard. All rights reserved.
//

import Foundation

var gGlobalLock: NSLock = NSLock()

public final class TextKitContext {
  private let layoutManager: NSLayoutManager
  private let textStorage: NSTextStorage
  private let textContainer: NSTextContainer
  
  private let internalLock: NSLock
  
  init(attributedString: NSAttributedString,
       lineBreakMode: NSLineBreakMode,
       maximumNumberOfLines: Int,
       constrainedSize: CGSize) {
    internalLock = NSLock()
    gGlobalLock.lock(); defer { gGlobalLock.unlock() }
    textStorage = NSTextStorage(attributedString: attributedString)
    layoutManager = NSLayoutManager()
    layoutManager.usesFontLeading = false
    textStorage.addLayoutManager(layoutManager)
    textContainer = NSTextContainer(size: constrainedSize)
    textContainer.lineFragmentPadding = 0
    textContainer.lineBreakMode = lineBreakMode
    textContainer.maximumNumberOfLines = maximumNumberOfLines
    layoutManager.addTextContainer(textContainer)
  }
  
  public func withLock(closure: (NSLayoutManager, NSTextStorage, NSTextContainer) -> ()) {
    internalLock.lock(); defer { internalLock.unlock() }
    closure(layoutManager, textStorage, textContainer)
  }
}
