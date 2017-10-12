//
//  CodeTextView.swift
//  Freetime
//
//  Created by Weyert de Boer on 12/10/2017.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class LineLayoutManager: NSLayoutManager {

    private var lastParagraphLocation: Int = 0
    private var lastParagraphNumber: Int = 0

    public var gutterTextColor = UIColor.darkGray
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
        let characterRange = NSMakeRange(range.location,lastParagraphLocation - range.location)
        var paragraphNumber = lastParagraphNumber

        if range.location == lastParagraphLocation {
            return lastParagraphNumber
        } else if range.location < lastParagraphLocation {
            currentString.enumerateSubstrings(in: characterRange, options:
            [.byParagraphs, .substringNotRequired, .reverse]) { substring, substringRange, enclosingRange, stop in
                if enclosingRange.location <= characterRange.location {
                    stop.pointee = true
                }

                paragraphNumber = paragraphNumber - 1
            }
        } else {
            currentString.enumerateSubstrings(in: range, options:
            [.byParagraphs, .substringNotRequired, .reverse]) { substring, substringRange, enclosingRange, stop in
                if enclosingRange.location >= characterRange.location {
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

    var gutterBackgroundColor: UIColor = .lightGray {
        didSet {
            setNeedsDisplay()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(frame: CGRect, textContainer: NSTextContainer? = nil) {
        super.init(frame: frame, textContainer: textContainer)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func draw(_ rect: CGRect) {
        // draw the guttee of the text view
        guard let context = UIGraphicsGetCurrentContext() else {
            super.draw(rect)
            return
        }

        // draw the gutter on the screen
        let viewBounds = self.bounds
        context.setFillColor(gutterBackgroundColor.cgColor)
        context.fill(CGRect(x: bounds.origin.x, y: bounds.origin.y, width: 40, height: bounds.size.height))
        context.setStrokeColor(UIColor.darkGray.cgColor)
        context.setLineWidth(0.5)
        context.stroke(CGRect(x: bounds.origin.x + 39.5, y: bounds.origin.y, width: 0.5, height: viewBounds.height))

        super.draw(rect)
    }
}

class CodeTextView: UIView {

    private let layoutManager = LineLayoutManager()
    private var internalTextView: InternalCodeTextView?

    var gutterBackgroundColor: UIColor = .lightGray {
        didSet {
            internalTextView?.gutterBackgroundColor = gutterBackgroundColor
        }
    }

    var gutterTextColor: UIColor = .blue {
        didSet {
            layoutManager.gutterTextColor = gutterTextColor
            print("woef")
            layoutManager.invalidateDisplay(forGlyphRange: NSMakeRange(0, 9999999))
            internalTextView?.setNeedsDisplay()
        }
    }

    var text: String? {
        didSet {
            internalTextView?.text = text
        }
    }

    var attributedText: NSAttributedString? {
        didSet {
            internalTextView?.attributedText = attributedText
        }
    }

    var font: UIFont? {
        didSet {
            internalTextView?.font = font
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    func setup() {

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

        internalTextView.frame = self.bounds
        internalTextView.gutterBackgroundColor = gutterBackgroundColor
        internalTextView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(internalTextView)
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
