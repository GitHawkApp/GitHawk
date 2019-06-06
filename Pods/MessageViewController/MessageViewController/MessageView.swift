//
//  MessageView.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/20/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

public final class MessageView: UIView, MessageTextViewListener {

    public let textView = MessageTextView()

    internal weak var delegate: MessageViewDelegate?
    internal let leftButton = ExpandedHitTestButton()
    internal let rightButton = ExpandedHitTestButton()
    internal let UITextViewContentSizeKeyPath = #keyPath(UITextView.contentSize)
    internal let topBorderLayer = CALayer()
    internal var contentView: UIView?
    internal var rightButtonAction: Selector?
    internal var leftButtonInset: CGFloat = 0
    internal var rightButtonInset: CGFloat = 0
    internal var ignoreLineHeight = false
    internal var suppressKVO = false
    
    public enum ButtonPosition {
        case left
        case right
    }

    internal var heightOffset: CGFloat = 0
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .white

        addSubview(leftButton)
        addSubview(textView)
        addSubview(rightButton)
        layer.addSublayer(topBorderLayer)

        //Set action button
        leftButton.imageEdgeInsets = .zero
        leftButton.titleEdgeInsets = .zero
        leftButton.contentEdgeInsets = .zero
        leftButton.titleLabel?.font = self.font ?? UIFont.systemFont(ofSize: 14)
        leftButton.imageView?.contentMode = .scaleAspectFit
        leftButton.imageView?.clipsToBounds = true

        // setup text view
        textView.contentInset = .zero
        textView.textContainerInset = .zero
        textView.backgroundColor = .clear
        textView.addObserver(self, forKeyPath: UITextViewContentSizeKeyPath, options: [.new], context: nil)
        textView.font = self.font ?? UIFont.systemFont(ofSize: 14)
        textView.add(listener: self)

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
        rightButton.imageEdgeInsets = .zero
        rightButton.titleEdgeInsets = .zero
        rightButton.contentEdgeInsets = .zero
        rightButton.titleLabel?.font = self.font ?? UIFont.systemFont(ofSize: 14)
        rightButton.imageView?.contentMode = .scaleAspectFit
        rightButton.imageView?.clipsToBounds = true

        updateEmptyTextStates()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        textView.removeObserver(self, forKeyPath: UITextViewContentSizeKeyPath)
    }

    // MARK: Public API

    public var showLeftButton: Bool = true {
        didSet {
            delegate?.wantsLayout(messageView: self)
        }
    }

    public var font: UIFont? {
        get { return textView.font }
        set {
            textView.font = newValue
            delegate?.wantsLayout(messageView: self)
        }
    }

    public var text: String {
        get { return textView.text ?? "" }
        set {
            textView.text = newValue
            delegate?.wantsLayout(messageView: self)
            updateEmptyTextStates()
        }
    }

    public var textViewInset: UIEdgeInsets {
        set {
            textView.textContainerInset = newValue
            setNeedsLayout()
            delegate?.wantsLayout(messageView: self)
        }
        get { return textView.textContainerInset }
    }

    public var contentInset: UIEdgeInsets {
        set {
            textView.contentInset = newValue
            setNeedsLayout()
            delegate?.wantsLayout(messageView: self)
        }
        get { return textView.contentInset }
    }

    /// - Parameter accessibilityLabel: A custom `accessibilityLabel` to set on the button.
    /// If none is supplied, it will default to the icon's `accessibilityLabel`.
    public func setButton(icon: UIImage?, for state: UIControl.State, position: ButtonPosition, accessibilityLabel: String? = nil) {
        let button: UIButton
        switch position {
        case .left:
            button = leftButton
        case .right:
            button = rightButton
        }
        button.setImage(icon, for: state)
        button.accessibilityLabel = accessibilityLabel ?? icon?.accessibilityIdentifier
        buttonLayoutDidChange(button: button)
    }

    /// - Parameter accessibilityLabel: A custom `accessibilityLabel` to set on the button.
    /// If none is supplied, it will default to the the supplied `title`.
    public func setButton(title: String, for state: UIControl.State, position: ButtonPosition, accessibilityLabel: String? = nil) {
        let button: UIButton
        switch position {
        case .left:
            button = leftButton
        case .right:
            button = rightButton
        }
        button.setTitle(title, for: state)
        button.accessibilityLabel = accessibilityLabel ?? title
        buttonLayoutDidChange(button: button)
    }

    public var leftButtonTint: UIColor {
        get { return leftButton.tintColor }
        set {
            leftButton.tintColor = newValue
            leftButton.setTitleColor(newValue, for: .normal)
            leftButton.imageView?.tintColor = newValue
        }
    }
    public var rightButtonTint: UIColor {
        get { return rightButton.tintColor }
        set {
            rightButton.tintColor = newValue
            rightButton.setTitleColor(newValue, for: .normal)
            rightButton.imageView?.tintColor = newValue
        }
    }
    
    public var maxHeight: CGFloat = CGFloat.greatestFiniteMagnitude {
        didSet {
            delegate?.wantsLayout(messageView: self)
        }
    }
    
    public var maxLineCount: Int = 4 {
        didSet {
            ignoreLineHeight = maxLineHeight == 0
            delegate?.wantsLayout(messageView: self)
        }
    }

    public var maxScreenRatio: CGFloat = 1 {
        didSet {
            maxScreenRatio = 0...1 ~= maxScreenRatio ? maxScreenRatio : 0
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

    public var keyboardType: UIKeyboardType {
        get { return textView.keyboardType }
        set { textView.keyboardType = newValue }
    }

    public func addButton(target: Any, action: Selector, position: ButtonPosition) {
        let button: UIButton
        switch position {
        case .left:
            button = leftButton
        case .right:
            button = rightButton
            rightButtonAction = action
        }
        
        button.addTarget(target, action: action, for: .touchUpInside)
    }

    public override var keyCommands: [UIKeyCommand]? {
        guard let action = rightButtonAction else { return nil }
        return [UIKeyCommand(input: "\r", modifierFlags: .command, action: action)]
    }

    public func setButton(inset: CGFloat, position: ButtonPosition) {
        switch position {
        case .left:
            leftButtonInset = inset
        case .right:
            rightButtonInset = inset
        }
        setNeedsLayout()
    }

    public func setButton(font: UIFont, position: ButtonPosition) {
        let button: UIButton
        switch position {
        case .left:
            button = leftButton
        case .right:
            button = rightButton
        }
        button.titleLabel?.font = font
        buttonLayoutDidChange(button: button)
    }

    public var bottomInset: CGFloat = 0 {
        didSet {
            delegate?.wantsLayout(messageView: self)
        }
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

        let leftButtonSize = leftButton.bounds.size
        let rightButtonSize = rightButton.bounds.size

        let textViewY = safeBounds.minY
        let textViewHeight = self.textViewHeight
        let textViewMaxY = textViewY + textViewHeight

        // adjust for font descender so button aligns with the text baseline
        let descender, pointSize: CGFloat
        if let font = textView.font {
            descender = floor(font.descender)
            pointSize = ceil(font.pointSize)
        } else {
            descender = 0
            pointSize = 0
        }
        let buttonYStarter = textViewMaxY - textViewInset.bottom - (pointSize - descender)/2

        // adjust by bottom offset so content is flush w/ text view
        let leftButtonFrame = CGRect(
            x: safeBounds.minX + leftButtonInset,
            y: buttonYStarter - leftButtonSize.height/2 + leftButton.bottomHeightOffset,
            width: leftButtonSize.width,
            height: leftButtonSize.height
        )
        leftButton.frame = showLeftButton ? leftButtonFrame : .zero

        let leftButtonMaxX = (showLeftButton ? leftButtonFrame.maxX : 0)
        let textViewFrame = CGRect(
            x: (showLeftButton ? leftButtonMaxX + leftButtonInset : 0),
            y: textViewY,
            width: safeBounds.width - leftButtonMaxX - rightButtonSize.width - rightButtonInset,
            height: textViewHeight
        )

        suppressKVO = true
        textView.frame = textViewFrame
        suppressKVO = false

        // adjust by bottom offset so content is flush w/ text view
        let rightButtonFrame = CGRect(
            x: textViewFrame.maxX,
            y: buttonYStarter - rightButtonSize.height/2 + rightButton.bottomHeightOffset,
            width: rightButtonSize.width,
            height: rightButtonSize.height
        )
        rightButton.frame = rightButtonFrame

        contentView?.frame = CGRect(
            x: safeBounds.minX,
            y: textViewFrame.maxY,
            width: safeBounds.width,
            height: contentView?.frame.height ?? 0
        )
    }

    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if suppressKVO == false, keyPath == UITextViewContentSizeKeyPath {
            textViewContentSizeDidChange()
        }
    }
    
    public override func resignFirstResponder() -> Bool {
        return textView.resignFirstResponder()
    }
    
    // MARK: Private API
    
    internal var height: CGFloat {
        return textViewHeight
            + (contentView?.bounds.height ?? 0)
            + bottomInset
    }
    
    internal var maxLineHeight: CGFloat {
        return (font?.lineHeight ?? 0) * CGFloat(maxLineCount)
    }
    
    internal var maxScreenRatioHeight: CGFloat {
        return maxScreenRatio * ((superview?.frame.height ?? 0) - heightOffset)
    }
    
    internal var calculatedMaxHeight: CGFloat {
        return ignoreLineHeight == true ? min(maxScreenRatioHeight, maxHeight) : min(maxScreenRatioHeight, maxLineHeight, maxHeight)
    }
    
    internal var textViewHeight: CGFloat {
        return ceil(min(calculatedMaxHeight, textView.contentSize.height))
    }
    
    internal func updateEmptyTextStates() {
        let isEmpty = text.isEmpty
        rightButton.isEnabled = !isEmpty
        rightButton.alpha = isEmpty ? 0.25 : 1
    }
    
    internal func buttonLayoutDidChange(button: UIButton) {
        button.sizeToFit()
        setNeedsLayout()
    }
    
    internal func textViewContentSizeDidChange() {
        delegate?.sizeDidChange(messageView: self)
        textView.alwaysBounceVertical = textView.contentSize.height > calculatedMaxHeight
    }
    
    // MARK: MessageTextViewListener

    public func didChange(textView: MessageTextView) {
        updateEmptyTextStates()
    }

    public func didChangeSelection(textView: MessageTextView) {
        delegate?.selectionDidChange(messageView: self)
    }
    
    public func willChangeRange(textView: MessageTextView, to range: NSRange) {}

}
