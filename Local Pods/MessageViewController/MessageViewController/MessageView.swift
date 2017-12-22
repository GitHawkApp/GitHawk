//
//  MessageView.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public final class MessageView: UIView {

    internal weak var delegate: MessageViewDelegate?

    internal let textView = UITextView()
    internal let placeholderLabel = UILabel()
    internal let button = UIButton()
    internal let UITextViewContentSizeKeyPath = #keyPath(UITextView.contentSize)
    internal let topBorderLayer = CALayer()
    internal var contentView: UIView?

    internal override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(placeholderLabel)
        addSubview(textView)
        addSubview(button)
        layer.addSublayer(topBorderLayer)

        // setup placeholder
        placeholderLabel.backgroundColor = .clear

        // setup text view
        textView.contentInset = .zero
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        textView.addObserver(self, forKeyPath: UITextViewContentSizeKeyPath, options: [.new], context: nil)
        textView.delegate = self

        // setup TextKit props to defaults
        textView.textContainer.exclusionPaths = []
        textView.textContainer.maximumNumberOfLines = 0
        textView.textContainer.lineFragmentPadding = 0
        textView.layoutManager.allowsNonContiguousLayout = false
        textView.layoutManager.hyphenationFactor = 0
        textView.layoutManager.showsInvisibleCharacters = false
        textView.layoutManager.showsControlCharacters = false
        textView.layoutManager.usesFontLeading = true

        // setup send button
        button.titleEdgeInsets = .zero
        button.contentEdgeInsets = .zero
        button.imageEdgeInsets = .zero

        updateEmptyTextStates()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        textView.removeObserver(self, forKeyPath: UITextViewContentSizeKeyPath)
    }

    // MARK: Public API

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

    public var font: UIFont? {
        get { return textView.font }
        set {
            placeholderLabel.font = font
            textView.font = newValue
            placeholderLayoutDidChange()
            delegate?.wantsLayout(messageView: self)
        }
    }

    public var text: String {
        get { return textView.text ?? "" }
        set {
            textView.text = newValue
            delegate?.wantsLayout(messageView: self)
        }
    }

    public var inset: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
            delegate?.wantsLayout(messageView: self)
        }
    }

    public var buttonLeftInset: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }

    public var buttonIcon: UIImage? {
        get { return button.imageView?.image }
        set {
            button.setImage(newValue, for: .normal)
            buttonLayoutDidChange()
        }
    }

    public var buttonTitle: String? {
        get { return button.title(for: .normal) }
        set {
            button.setTitle(newValue, for: .normal)
            buttonLayoutDidChange()
        }
    }

    public var buttonTint: UIColor {
        get { return button.tintColor }
        set {
            button.tintColor = newValue
            button.setTitleColor(newValue, for: .normal)
            button.imageView?.tintColor = newValue
        }
    }

    public var borderColor: UIColor? {
        get {
            guard let color = topBorderLayer.backgroundColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            topBorderLayer.backgroundColor = newValue?.cgColor
        }
    }

    public var maxLineCount: Int = 4 {
        didSet {
            delegate?.wantsLayout(messageView: self)
        }
    }

    public func add(contentView: UIView) {
        self.contentView?.removeFromSuperview()
        assert(contentView.bounds.height > 0, "Must have a non-zero content height")
        self.contentView = contentView
        addSubview(contentView)
        setNeedsLayout()
        delegate?.wantsLayout(messageView: self)
    }

    // MARK: Overrides

    public override func layoutSubviews() {
        super.layoutSubviews()

        topBorderLayer.frame = CGRect(
            x: bounds.minX,
            y: bounds.minY,
            width: bounds.width,
            height: 1 / UIScreen.main.scale
        )

        let safeBounds = CGRect(
            x: bounds.minX + util_safeAreaInsets.left,
            y: bounds.minY,
            width: bounds.width - util_safeAreaInsets.left - util_safeAreaInsets.right,
            height: bounds.height
        )
        let insetBounds = UIEdgeInsetsInsetRect(safeBounds, inset)

        let buttonSize = button.bounds.size

        let textViewFrame = CGRect(
            x: insetBounds.minX,
            y: insetBounds.minY,
            width: insetBounds.width - buttonSize.width - buttonLeftInset,
            height: textViewHeight
        )
        textView.frame = textViewFrame

        let placeholderSize = placeholderLabel.bounds.size
        placeholderLabel.frame = CGRect(
            x: textViewFrame.minX,
            y: textViewFrame.minY,
            width: placeholderSize.width,
            height: placeholderSize.height
        )

        // adjust by bottom offset so content is flush w/ text view
        button.frame = CGRect(
            x: textViewFrame.maxX + buttonLeftInset,
            y: textViewFrame.maxY - buttonSize.height + button.bottomHeightOffset,
            width: buttonSize.width,
            height: buttonSize.height
        )

        let contentY = textViewFrame.maxY + inset.bottom
        contentView?.frame = CGRect(
            x: safeBounds.minX,
            y: contentY,
            width: safeBounds.width,
            height: bounds.height - contentY - util_safeAreaInsets.bottom
        )
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == UITextViewContentSizeKeyPath {
            textViewContentSizeDidChange()
        }
    }

    public override func resignFirstResponder() -> Bool {
        return textView.resignFirstResponder()
    }

    // MARK: Private API

    internal var height: CGFloat {
        return inset.top
            + inset.bottom
            + textViewHeight
            + (contentView?.bounds.height ?? 0)
    }

    internal var textViewHeight: CGFloat {
        return min(maxHeight, textView.contentSize.height)
    }

    internal var maxHeight: CGFloat {
        return (font?.lineHeight ?? 0) * CGFloat(maxLineCount)
    }

    internal func updateEmptyTextStates() {
        let isEmpty = text.isEmpty
        placeholderLabel.isHidden = !isEmpty
        button.isEnabled = !isEmpty
        button.alpha = isEmpty ? 0.25 : 1
    }

    internal func placeholderLayoutDidChange() {
        placeholderLabel.sizeToFit()
        setNeedsLayout()
    }

    internal func buttonLayoutDidChange() {
        button.sizeToFit()
        setNeedsLayout()
    }

}
