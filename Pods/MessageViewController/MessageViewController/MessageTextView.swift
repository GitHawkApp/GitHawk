//
//  MessageTextView.swift
//  MessageViewController
//
//  Created by Ryan Nystrom on 12/31/17.
//

import UIKit

public protocol MessageTextViewListener: class {
    func didChange(textView: MessageTextView)
    func didChangeSelection(textView: MessageTextView)
    func willChangeRange(textView: MessageTextView, to range: NSRange)
}

open class MessageTextView: UITextView, UITextViewDelegate {

    internal let placeholderLabel = UILabel()
    internal var listeners: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    open override var delegate: UITextViewDelegate? {
        get { return self }
        set {}
    }

    open var defaultFont = UIFont.preferredFont(forTextStyle: .body) {
        didSet {
            defaultTextAttributes[.font] = defaultFont
        }
    }

    open var defaultTextColor = UIColor.black {
        didSet {
            defaultTextAttributes[NSAttributedString.Key.foregroundColor] = defaultTextColor
        }
    }

    internal var defaultTextAttributes: [NSAttributedString.Key: Any] = {
        let style = NSMutableParagraphStyle()
        style.paragraphSpacingBefore = 2
        style.lineHeightMultiple = 1
        return [NSAttributedString.Key.paragraphStyle: style]
        }() {
        didSet {
            typingAttributes = defaultTextAttributes
        }
    }

    open override var font: UIFont? {
        didSet {
            defaultFont = font ?? .preferredFont(forTextStyle: .body)
            placeholderLabel.font = font
            placeholderLayoutDidChange()
        }
    }

    open override var textColor: UIColor? {
        didSet {
            defaultTextColor = textColor ?? .black
        }
    }

    open override var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
            placeholderLayoutDidChange()
        }
    }

    open override var attributedText: NSAttributedString! {
        get { return super.attributedText }
        set {
            let didChange = super.attributedText != newValue
            super.attributedText = newValue
            if didChange {
                textViewDidChange(self)
            }
        }
    }

    public override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    // MARK: Public API

    public func add(listener: MessageTextViewListener) {
        assert(Thread.isMainThread)
        listeners.add(listener)
    }

    public var placeholderText: String {
        get { return placeholderLabel.text ?? "" }
        set {
            placeholderLabel.text = newValue
            placeholderLayoutDidChange()
        }
    }

    public var placeholderTextColor: UIColor {
        get { return placeholderLabel.textColor }
        set { placeholderLabel.textColor = newValue }
    }

    // MARK: Overrides

    open override func layoutSubviews() {
        super.layoutSubviews()

        let placeholderSize = placeholderLabel.bounds.size
        placeholderLabel.frame = CGRect(
            x: textContainerInset.left,
            y: textContainerInset.top,
            width: placeholderSize.width,
            height: placeholderSize.height
        )
    }

    // MARK: Private API

    private func commonInit() {
        placeholderLabel.backgroundColor = .clear
        placeholderLabel.font = font
        placeholderLabel.textColor = textColor
        placeholderLabel.textAlignment = textAlignment
        addSubview(placeholderLabel)
        updatePlaceholderVisibility()

        defaultTextAttributes[NSAttributedString.Key.font] = defaultFont
        defaultTextAttributes[NSAttributedString.Key.foregroundColor] = defaultTextColor
    }

    internal func enumerateListeners(block: (MessageTextViewListener) -> Void) {
        for listener in listeners.objectEnumerator() {
            guard let listener = listener as? MessageTextViewListener else { continue }
            block(listener)
        }
    }

    private func placeholderLayoutDidChange() {
        placeholderLabel.sizeToFit()
        setNeedsLayout()
    }

    private func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !text.isEmpty
    }

    // MARK: UITextViewDelegate

    public func textViewDidChange(_ textView: UITextView) {
        typingAttributes = defaultTextAttributes
        updatePlaceholderVisibility()
        enumerateListeners { $0.didChange(textView: self) }
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        enumerateListeners { $0.didChangeSelection(textView: self) }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        enumerateListeners { $0.willChangeRange(textView: self, to: range) }
        return true
    }

}
