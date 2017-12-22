//
//  MessageViewController.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

open class MessageViewController: UIViewController {

    public let messageView = MessageView()
    public let autocompleteTableView = UITableView()
    public weak var autocompleteDelegate: MessageViewControllerAutocompleteDelegate?

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

    // MARK: Public API

    public final func setup(scrollView: UIScrollView) {
        self.scrollView = scrollView

        if scrollView.superview != view {
            view.addSubview(scrollView)
        }
        scrollView.panGestureRecognizer.addTarget(self, action: #selector(onPan(gesture:)))

        view.addSubview(autocompleteTableView)
        view.addSubview(messageView)
    }

    public func register(prefix: String) {
        registeredPrefixes.insert(prefix)
    }

    // MARK: Private API

    // keyboard management
    internal enum KeyboardState {
        case visible
        case resigned
        case showing
        case hiding
    }
    internal var keyboardState: KeyboardState = .resigned
    internal var scrollView: UIScrollView!
    internal var keyboardHeight: CGFloat = 0

    // autocomplete
    struct CurrentAutocomplete {
        let prefix: String
        let word: String
        let range: NSRange
    }
    internal var registeredPrefixes = Set<String>()
    internal var currentAutocomplete: CurrentAutocomplete?

    internal func commonInit() {
        messageView.delegate = self

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }

    internal var safeAreaAdditionalHeight: CGFloat {
        switch keyboardState {
        case .hiding, .resigned: return view.util_safeAreaInsets.bottom
        case .showing, .visible: return 0
        }
    }

    internal func layout() {
        let bounds = view.bounds

        let messageViewHeight = messageView.height
        let safeAreaAdditionalHeight = self.safeAreaAdditionalHeight
        let messageViewFrame = CGRect(
            x: bounds.minX,
            y: bounds.minY + bounds.height - messageViewHeight - keyboardHeight - safeAreaAdditionalHeight,
            width: bounds.width,
            height: messageViewHeight + safeAreaAdditionalHeight
        )
        messageView.frame = messageViewFrame

        scrollView.frame = CGRect(
            x: bounds.minX,
            y: bounds.minY,
            width: bounds.width,
            height: messageViewFrame.minY
        )

        // required for the nested UITextView to layout its internals correctly
        messageView.layoutIfNeeded()
    }

    internal func checkForAutocomplete() {
        guard let result = messageView.textView.find(prefixes: registeredPrefixes) else { return }
        if autocompleteDelegate?.shouldHandleFindPrefix(prefix: result.prefix, word: result.word) == true {
            currentAutocomplete = CurrentAutocomplete(prefix: result.prefix, word: result.word, range: result.range)
        } else {
            currentAutocomplete = nil
        }
    }

    // MARK: Keyboard notifications

    @objc internal func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }

        scrollView.stopScrolling()
        keyboardState = .showing
        keyboardHeight = keyboardFrame.height

        UIView.animate(withDuration: animationDuration) {
            self.layout()

            let scrollViewHeight = self.scrollView.bounds.height
            let contentHeight = self.scrollView.contentSize.height
            let contentOffset = self.scrollView.contentOffset.y
            let topInset = self.scrollView.util_adjustedContentInset.top

            let newOffset = max(
                min(
                    contentHeight - scrollViewHeight,
                    contentOffset + self.keyboardHeight - self.view.util_safeAreaInsets.bottom
                ),
                -topInset
            )
            self.scrollView.contentOffset = CGPoint(x: 0, y: newOffset)
        }
    }

    // MARK: Keyboard Notifications

    @objc internal func keyboardDidShow(notification: Notification) {
        keyboardState = .visible
    }

    @objc internal func keyboardWillHide(notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
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

    @objc internal func keyboardWillChangeFrame(notification: Notification) {

    }

    @objc internal func keyboardDidChangeFrame(notification: Notification) {

    }

    // MARK: Gestures

    @objc internal func onPan(gesture: UIPanGestureRecognizer) {
        guard gesture.state == .changed else { return }
        let location = gesture.location(in: view)
        if messageView.frame.contains(location) {
            let _ = messageView.resignFirstResponder()
        }
    }

}
