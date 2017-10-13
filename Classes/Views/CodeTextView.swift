//
//  CodeTextView.swift
//  Freetime
//
//  Created by Weyert de Boer on 12/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import Highlightr

final class LineLayoutManager: NSLayoutManager {

    private var lastParagraphLocation: Int = 0
    private var lastParagraphNumber: Int = 0

    public var gutterTextColor = UIColor.fromHex("#A4A4A4")
    public var gutterFont = UIFont.systemFont(ofSize: 11.0)

    public override init() {
        super.init()
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func resetState() {
        lastParagraphLocation = 0
        lastParagraphNumber = 0
    }

    private func paragraphForRange(range: NSRange) -> Int {
        let currentString = NSString(string: self.textStorage?.string ?? "")
        var paragraphNumber = lastParagraphNumber

        if range.location == lastParagraphLocation {
            return lastParagraphNumber
        } else if range.location < lastParagraphLocation {
            let characterRange = NSMakeRange(range.location, lastParagraphLocation - range.location)
            currentString.enumerateSubstrings(in: characterRange, options:
            [.byParagraphs, .substringNotRequired, .reverse]) { substring, substringRange, enclosingRange, stop in
                if enclosingRange.location <= range.location {
                    stop.pointee = true
                }

                paragraphNumber = paragraphNumber - 1
            }
        } else {
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

    func drawGutterLineNumber(_ line: Int, in rect: CGRect) {
        let gutterAttributes: [NSAttributedStringKey: Any] = [
            NSAttributedStringKey.foregroundColor: gutterTextColor,
            NSAttributedStringKey.font: gutterFont
        ]

        let gutterLineNumber = "\(line )" as NSString
        let gutterLineSize = gutterLineNumber.size(withAttributes: gutterAttributes)

        let targetRect = rect.offsetBy(dx: rect.width - 4 - gutterLineSize.width, dy: (rect.height - gutterLineSize.height) / 2)
        gutterLineNumber.draw(in: targetRect, withAttributes: gutterAttributes)
    }

    override func drawBackground(forGlyphRange glyphsToShow: NSRange, at origin: CGPoint) {
        super.drawBackground(forGlyphRange: glyphsToShow, at: origin)

        var gutterRect: CGRect = .zero
        var paragraphNumber = 0

        enumerateLineFragments(forGlyphRange: glyphsToShow) { [weak self] rect, usedRect, textContainer, glyphRange, pointee in
            guard let weakSelf = self, let textStorage = self?.textStorage else { return }

            let charRange = weakSelf.characterRange(forGlyphRange: glyphRange, actualGlyphRange: nil)
            let paraRange = NSString(string: textStorage.string).paragraphRange(for: charRange)
            if charRange.location == paraRange.location {
                gutterRect = CGRect(x: 0, y: rect.origin.y, width: 40, height: rect.size.height).offsetBy(dx: origin.x, dy: origin.y)
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
            resetState()
        }
    }
}

private class InternalCodeTextView: UITextView {

    var gutterBackgroundColor: UIColor = UIColor.fromHex("#F5F9F7") {
        didSet {
            setNeedsDisplay()
        }
    }

    var gutterLineColor: UIColor = UIColor.fromHex("#E2E5E4") {
        didSet {
            setNeedsDisplay()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    override init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        // Cause drawRect: to be called on frame resizing and device rotation
        self.contentMode = .redraw
    }

    override func draw(_ rect: CGRect) {
        // draw the guttee of the text view
        guard let context = UIGraphicsGetCurrentContext() else {
            super.draw(rect)
            return
        }

        let gutterWidth: CGFloat = 40
        let gutterStrokeWidth: CGFloat = 0.5

        // draw the gutter on the screen
        let viewBounds = self.bounds
        context.setFillColor(gutterBackgroundColor.cgColor)
        context.fill(CGRect(x: bounds.origin.x, y: bounds.origin.y, width: gutterWidth, height: bounds.size.height))
        context.setStrokeColor(gutterLineColor.cgColor)
        context.setLineWidth(gutterStrokeWidth)
        context.stroke(CGRect(x: bounds.origin.x + (gutterWidth - gutterStrokeWidth), y: bounds.origin.y, width: gutterStrokeWidth, height: viewBounds.height))

        super.draw(rect)
    }
}

public class CodeTextView: UIView {

    private let layoutManager = LineLayoutManager()
    private var internalTextView: InternalCodeTextView?

    public var isEditable: Bool = true {
        didSet {
            internalTextView?.isEditable = isEditable
        }
    }

    public var gutterBackgroundColor: UIColor = UIColor.fromHex("#F5F9F7") {
        didSet {
            internalTextView?.gutterBackgroundColor = gutterBackgroundColor
        }
    }

    override public var backgroundColor: UIColor? {
        didSet {
            internalTextView?.backgroundColor = backgroundColor
            internalTextView?.setNeedsDisplay()
        }
    }

    public var gutterTextColor: UIColor = UIColor.fromHex("#A8A8A8") {
        didSet {
            layoutManager.gutterTextColor = gutterTextColor
            internalTextView?.setNeedsDisplay()
        }
    }

    public var text: String? {
        didSet {
            internalTextView?.text = text
        }
    }

    public var attributedText: NSAttributedString? {
        didSet {
            internalTextView?.attributedText = attributedText
        }
    }

    public var font: UIFont? {
        didSet {
            internalTextView?.font = font
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {
        // Cause drawRect: to be called on frame resizing and device rotation
        self.contentMode = .redraw

        // Assign the `UITextView`'s `NSLayoutManager` to the `NSTextStorage` subclass
        let textStorage = NSTextStorage()
        textStorage.addLayoutManager(layoutManager)

        let textContainer = NSTextContainer()
        textContainer.widthTracksTextView = true
        textContainer.exclusionPaths = [
            UIBezierPath(rect: CGRect(x: 0, y: 0, width: 40, height: CGFloat.greatestFiniteMagnitude))
        ]
        layoutManager.addTextContainer(textContainer)
        textContainer.layoutManager = layoutManager

        internalTextView = InternalCodeTextView(frame: self.bounds, textContainer: textContainer)
        guard let internalTextView = internalTextView else { return }

        backgroundColor = UIColor.fromHex("#F5F9F7")
        internalTextView.frame = self.bounds
        internalTextView.gutterBackgroundColor = gutterBackgroundColor
        internalTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(internalTextView)
    }

    override public func layoutSubviews() {
        self.internalTextView?.frame = self.bounds
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
