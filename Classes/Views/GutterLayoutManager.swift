//
//  GutterLayoutManager.swift
//  Freetime
//
//  Created by Weyert de Boer on 15/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import Foundation

protocol GutterLayoutManagerDelegate: class {

    func getLineForLine(gutterLayoutManager: GutterLayoutManager, lineNumber: Int, for line: String) -> String

    func getMaximumGutterWidth(gutterLayoutManager: GutterLayoutManager) -> CGFloat
}

extension GutterLayoutManagerDelegate {

    func getLineForLine(gutterLayoutManager: GutterLayoutManager, lineNumber: Int, for line: String) -> String {
        return "\(lineNumber)"
    }

    func getMaximumGutterWidth(gutterLayoutManager: GutterLayoutManager) -> CGFloat {
        guard let textStorage = gutterLayoutManager.textStorage else { return 0 }
        let numberOfLines = textStorage.string.components(separatedBy: .newlines).count
        let maxLength = "\(numberOfLines)".count
        let fillerString = String(repeating: "9", count: maxLength)
        let maxGutterSize = (fillerString as NSString).size(withAttributes: [NSAttributedStringKey.font: gutterLayoutManager.gutterFont])
        return ceil(maxGutterSize.width)
    }
}

class GutterTextContainer: NSTextContainer {

    override func lineFragmentRect(forProposedRect proposedRect: CGRect, at characterIndex: Int, writingDirection baseWritingDirection: NSWritingDirection, remaining remainingRect: UnsafeMutablePointer<CGRect>?) -> CGRect {

        var lineFragmentRect = super.lineFragmentRect(
            forProposedRect: proposedRect,
            at: characterIndex,
            writingDirection: baseWritingDirection,
            remaining: remainingRect
        )

        guard let layoutManager = self.layoutManager as? GutterLayoutManager else { return lineFragmentRect }
        let fragmentInsets = layoutManager.insetsForLineStarting(at: characterIndex)
        lineFragmentRect.size.width -= fragmentInsets.left + fragmentInsets.right
        return lineFragmentRect
    }
}

/**
 GutterLayoutManager allows the drawing of gutter with line number on the left side of
 a text view. A `GutterLayoutManagerDelegate` is availabla which is being used to query the
 actual line number to be rendered on the screen. This useful when the to be rendered line number
 differs from the internal line number in the text.

 In the code base this is used to render the correct line numbers for a diff
 **/
class GutterLayoutManager: NSLayoutManager {

    private let paragraphPadding: CGFloat = 4

    private var lastParagraphLocation: Int = 0
    private var lastParagraphNumber: Int = 0

    private var gutterWidth: CGFloat {
        return CGFloat(gutterDelegate?.getMaximumGutterWidth(gutterLayoutManager: self) ?? Styles.Sizes.defaultGutterWidth)
    }

    public var showGutter: Bool = false {
        didSet {
            guard let textStorage = self.textStorage else { return }
            self.invalidateDisplay(forCharacterRange: NSMakeRange(0, textStorage.length))
        }
    }

    public var showLineNumbers: Bool = true {
        didSet {
            guard let textStorage = self.textStorage else { return }
            self.invalidateDisplay(forCharacterRange: NSMakeRange(0, textStorage.length))
        }
    }

    public var gutterTextColor = Styles.Colors.Gray.gutter.color {
        didSet {
            guard let textStorage = self.textStorage else { return }
            self.invalidateDisplay(forCharacterRange: NSMakeRange(0, textStorage.length))
        }
    }

    public var gutterFont = Styles.Fonts.gutter {
        didSet {
            guard let textStorage = self.textStorage else { return }
            self.invalidateDisplay(forCharacterRange: NSMakeRange(0, textStorage.length))
        }
    }
    public weak var gutterDelegate: GutterLayoutManagerDelegate?

    public override init() {
        super.init()
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(delegate: GutterLayoutManagerDelegate?) {
        self.init()
        self.gutterDelegate = delegate
    }

    private func resetState() {
        lastParagraphLocation = 0
        lastParagraphNumber = 0
    }

    // Original implementation sourced from: https://github.com/alldritt/TextKit_LineNumbers
    private func paragraphForRange(range: NSRange) -> Int {
        //  NSString does not provide a means of efficiently determining the paragraph number of a range of text.  This code
        //  attempts to optimize what would normally be a series linear searches by keeping track of the last paragraph number
        //  found and uses that as the starting point for next paragraph number search.  This works (mostly) because we
        //  are generally asked for continguous increasing sequences of paragraph numbers.  Also, this code is called in the
        //  course of drawing a pagefull of text, and so even when moving back, the number of paragraphs to search for is
        //  relativly low, even in really long bodies of text.
        //
        //  This all falls down when the user edits the text, and can potentially invalidate the cached paragraph number which
        //  causes a (potentially lengthy) search from the beginning of the string.

        let currentString = NSString(string: self.textStorage?.string ?? "")
        var paragraphNumber = lastParagraphNumber

        if range.location == lastParagraphLocation {
            return lastParagraphNumber
        } else if range.location < lastParagraphLocation {
            //  We need to look backwards from the last known paragraph for the new paragraph range.  This generally happens
            //  when the text in the UITextView scrolls downward, revaling paragraphs before/above the ones previously drawn.

            let characterRange = NSMakeRange(range.location, lastParagraphLocation - range.location)
            currentString.enumerateSubstrings(in: characterRange, options:
            [.byParagraphs, .substringNotRequired, .reverse]) { substring, substringRange, enclosingRange, stop in
                if enclosingRange.location <= range.location {
                    stop.pointee = true
                }

                paragraphNumber = paragraphNumber - 1
            }
        } else {
            //  We need to look forward from the last known paragraph for the new paragraph range.  This generally happens
            //  when the text in the UITextView scrolls upwards, revealing paragraphs that follow the ones previously drawn.

            let characterRange = NSMakeRange(self.lastParagraphLocation, range.location - self.lastParagraphLocation)
            currentString.enumerateSubstrings(in: characterRange, options:
            [.byParagraphs, .substringNotRequired]) { substring, substringRange, enclosingRange, stop in
                if enclosingRange.location >= range.location {
                    stop.pointee = true
                }

                paragraphNumber = paragraphNumber + 1
            }
        }

        lastParagraphLocation = range.location
        lastParagraphNumber = paragraphNumber

        return paragraphNumber
    }

    private func drawGutterLineNumber(_ line: Int, in rect: CGRect) {
        let gutterAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: gutterTextColor,
            NSAttributedStringKey.font: gutterFont
        ]

        let actualLineNumber = gutterDelegate?.getLineForLine(gutterLayoutManager: self, lineNumber: line, for: "") ?? "\(line)"
        let gutterLineNumber = actualLineNumber as NSString
        let gutterLineSize = gutterLineNumber.size(withAttributes: gutterAttributes)

        let targetRect = rect.offsetBy(dx: rect.width - paragraphPadding - gutterLineSize.width, dy: (rect.height - gutterLineSize.height) / 2)
        gutterLineNumber.draw(in: targetRect, withAttributes: gutterAttributes)
    }

    public func insetsForLineStarting(at characterIndex: Int) -> UIEdgeInsets {
        if !showGutter {
            return .zero
        }

        let gutterWidth: CGFloat = self.gutterDelegate?.getMaximumGutterWidth(gutterLayoutManager: self) ?? 0
        return UIEdgeInsets(top: 0, left: gutterWidth, bottom: 0, right: 0)
    }

    override func setLineFragmentRect(_ fragmentRect: CGRect, forGlyphRange glyphRange: NSRange, usedRect: CGRect) {
        let insets = self.insetsForLineStarting(at: self.characterIndexForGlyph(at: glyphRange.location))

        let newUsedRect = usedRect.offsetBy(dx:insets.left, dy: 0)
        let newFragmentRect = fragmentRect.offsetBy(dx: insets.left, dy: 0)

        super.setLineFragmentRect(newFragmentRect, forGlyphRange: glyphRange, usedRect: newUsedRect)
    }

    override func setExtraLineFragmentRect(_ fragmentRect: CGRect, usedRect: CGRect, textContainer container: NSTextContainer) {
        guard let textStorage = self.textStorage else {
            super.setExtraLineFragmentRect(fragmentRect, usedRect: usedRect, textContainer: container)
            return
        }

        let insets = self.insetsForLineStarting(at: self.characterIndexForGlyph(at: textStorage.length))
        let newFragmentRect = fragmentRect.offsetBy(dx: insets.left, dy: 0)
        let newUsedRect = usedRect.offsetBy(dx:insets.left, dy: 0)

        super.setExtraLineFragmentRect(newFragmentRect, usedRect: newUsedRect, textContainer: container)
    }

    override func drawBackground(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawBackground(forGlyphRange: glyphsToShow, at: origin)

        guard showGutter, showLineNumbers else {
            return
        }

        var gutterRect: CGRect = .zero
        var paragraphNumber = 0

        enumerateLineFragments(forGlyphRange: glyphsToShow) { [weak self] rect, usedRect, textContainer, glyphRange, pointee in
            guard let weakSelf = self, let textStorage = self?.textStorage else { return }

            let charRange = weakSelf.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            let paraRange = NSString(string: textStorage.string).paragraphRange(for: charRange)
            if charRange.location == paraRange.location {
                gutterRect = CGRect(x: 0, y: rect.origin.y, width: weakSelf.gutterWidth, height: rect.size.height).offsetBy(dx: origin.x, dy: origin.y)
                paragraphNumber = weakSelf.paragraphForRange(range: charRange)
                weakSelf.drawGutterLineNumber(paragraphNumber + 1, in: gutterRect)
            }
        }

        if NSMaxRange(glyphsToShow) < self.numberOfGlyphs {
            gutterRect = gutterRect.offsetBy(dx: 0, dy: gutterRect.height)
            drawGutterLineNumber(paragraphNumber + 2, in: gutterRect)
        }
    }

    override func processEditing(for textStorage: NSTextStorage, edited editMask: NSTextStorageEditActions, range newCharRange: NSRange, changeInLength delta: Int, invalidatedRange invalidatedCharRange: NSRange) {
        super.processEditing(for: textStorage, edited: editMask, range: newCharRange, changeInLength: delta, invalidatedRange: invalidatedCharRange)

        if invalidatedCharRange.location < lastParagraphLocation {
            //  When the backing store is edited ahead the cached paragraph location, invalidate the cache and force a complete
            //  recalculation.  We cannot be much smarter than this because we don't know how many paragraphs have been deleted
            //  since the text has already been removed from the backing store.

            resetState()
        }
    }
}
