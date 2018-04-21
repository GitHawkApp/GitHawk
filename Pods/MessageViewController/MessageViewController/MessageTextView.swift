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

    private let placeholderLabel = UILabel()

    private var listeners: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    open override var delegate: UITextViewDelegate? {
        get { return self }
        set {}
    }

    open override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
            placeholderLayoutDidChange()
        }
    }

    open override var textAlignment: NSTextAlignment {
        didSet {
            placeholderLabel.textAlignment = textAlignment
            placeholderLayoutDidChange()
        }
    }

    open override var text: String! {
        didSet {
            updatePlaceholderVisibility()
        }
    }

    open override var attributedText: NSAttributedString! {
        didSet {
            updatePlaceholderVisibility()
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
    }

    private func enumerateListeners(block: (MessageTextViewListener) -> Void) {
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
