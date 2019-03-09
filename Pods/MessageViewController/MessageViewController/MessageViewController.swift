//
//  MessageViewController.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

open class MessageViewController: UIViewController, MessageAutocompleteControllerLayoutDelegate {

    public let messageView = MessageView()
    public private(set) lazy var messageAutocompleteController: MessageAutocompleteController = {
        return MessageAutocompleteController(textView: self.messageView.textView)
    }()
    public var cacheKey: String?

    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        messageView.text = cachedText ?? ""
    }

    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cache()
        messageView.textView.resignFirstResponder()
    }

    // MARK: Public API

    public final func setup(scrollView: UIScrollView) {
        self.scrollView = scrollView

        if scrollView.superview != view {
            view.addSubview(scrollView)
        }
        scrollView.panGestureRecognizer.addTarget(self, action: #selector(onPan(gesture:)))
        scrollView.keyboardDismissMode = .none

        view.addSubview(messageView)
    }

    public var borderColor: UIColor? {
        get { return messageAutocompleteController.borderColor }
        set {
            messageAutocompleteController.borderColor = newValue
            messageView.topBorderLayer.backgroundColor = newValue?.cgColor
        }
    }

    public func setMessageView(hidden: Bool, animated: Bool) {
        isMessageViewHidden = hidden
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.layout()
        }
    }

    open func didLayout() { }

    // MARK: Private API

    // keyboard management
    internal enum KeyboardState {
        case visible
        case resigned
        case showing
        case hiding
    }
    internal var keyboardState: KeyboardState = .resigned
    internal var scrollView: UIScrollView?
    internal var keyboardHeight: CGFloat = 0
    internal var isMessageViewHidden = false

    internal func commonInit() {
        messageView.delegate = self
        messageAutocompleteController.layoutDelegate = self

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillResignActive(notification:)), name: UIApplication.willResignActiveNotification, object: nil)
    }

    internal var safeAreaAdditionalHeight: CGFloat {
        switch keyboardState {
        case .hiding, .resigned: return view.util_safeAreaInsets.bottom
        case .showing, .visible: return 0
        }
    }

    internal func layout(updateOffset: Bool = false) {
        guard let scrollView = self.scrollView else { return }

        let bounds = view.bounds

        let safeAreaAdditionalHeight = self.safeAreaAdditionalHeight
        let messageViewHeight = messageView.height + safeAreaAdditionalHeight
        let hiddenHeight = isMessageViewHidden ? messageViewHeight : 0

        let messageViewFrame = CGRect(
            x: bounds.minX,
            y: bounds.minY + bounds.height - messageViewHeight - keyboardHeight + hiddenHeight,
            width: bounds.width,
            height: messageViewHeight
        )
        messageView.frame = messageViewFrame

        // required for the nested UITextView to layout its internals correctly
        messageView.layoutIfNeeded()

        let originalOffset = scrollView.contentOffset
        let heightChange = scrollView.frame.height - messageViewFrame.minY

        scrollView.frame = CGRect(
            x: bounds.minX,
            y: bounds.minY,
            width: bounds.width,
            height: messageViewFrame.minY
        )

        if updateOffset, heightChange != 0 {
            scrollView.contentOffset = CGPoint(
                x: originalOffset.x,
                y: max(originalOffset.y + heightChange, -scrollView.util_adjustedContentInset.top)
            )
        }

        messageAutocompleteController.layout(in: view, bottomY: messageViewFrame.minY)

        didLayout()
    }

    internal var fullCacheKey: String? {
        guard let key = cacheKey else { return nil }
        return "com.freetime.MessageViewController.\(key)"
    }

    internal func cache() {
        guard let key = fullCacheKey else { return }
        let text = messageView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        let defaults = UserDefaults.standard
        if text.isEmpty {
            defaults.removeObject(forKey: key)
        } else {
            defaults.set(text, forKey: key)
        }
    }

    var cachedText: String? {
        guard let key = fullCacheKey else { return nil }
        return UserDefaults.standard.string(forKey: key)
    }

    // MARK: Notifications

    @objc internal func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }

        scrollView?.stopScrolling()
        keyboardState = .showing

        let previousKeyboardHeight = keyboardHeight
        keyboardHeight = keyboardFrame.height
        messageView.heightOffset = keyboardHeight + (scrollView?.util_safeAreaInsets.top ?? 0)
        
        UIView.animate(withDuration: animationDuration) {
            guard let scrollView = self.scrollView else { return }
            // capture before changing the frame which might have weird side effects
            let contentOffset = scrollView.contentOffset

            self.layout()

            let scrollViewHeight = scrollView.bounds.height
            let contentHeight = scrollView.contentSize.height
            let inset = scrollView.util_adjustedContentInset
            let bottomSafeInset = self.view.util_safeAreaInsets.bottom

            let newOffset = max(
                min(
                    contentHeight - scrollViewHeight + inset.bottom,
                    contentOffset.y + self.keyboardHeight - previousKeyboardHeight - bottomSafeInset
                ),
                -inset.top
            )
            scrollView.contentOffset = CGPoint(x: contentOffset.x, y: newOffset)
        }
    }

    @objc internal func keyboardDidShow(notification: Notification) {
        keyboardState = .visible
    }

    @objc internal func keyboardWillHide(notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }

        keyboardState = .hiding
        keyboardHeight = 0

        UIView.animate(withDuration: animationDuration) {
            self.layout()
        }
    }

    @objc internal func keyboardDidHide(notification: Notification) {
        keyboardState = .resigned
    }

    @objc internal func appWillResignActive(notification: Notification) {
        cache()
    }

    // MARK: Gestures

    @objc internal func onPan(gesture: UIPanGestureRecognizer) {
        guard gesture.state == .changed else { return }
        let location = gesture.location(in: view)
        if messageView.frame.contains(location) {
            let _ = messageView.resignFirstResponder()
        }
    }

    // MARK: MessageAutocompleteControllerLayoutDelegate

    public func needsLayout(controller: MessageAutocompleteController) {
        view.setNeedsLayout()
    }

}
