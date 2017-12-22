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

    public final func register(prefix: String) {
        registeredPrefixes.insert(prefix)
    }

    public final func showAutocomplete(_ doShow: Bool) {
        if doShow {
            autocompleteTableView.reloadData()
            autocompleteTableView.layoutIfNeeded()
        }
        autocompleteTableView.isHidden = !doShow
        view.setNeedsLayout()
    }

    public final func accept(autocomplete: String, keepPrefix: Bool = true) {
        defer { cancelAutocomplete() }

        guard let current = currentAutocomplete else { return }

        let prefixLength = current.prefix.utf16.count
        let insertionRange = NSRange(
            location: current.range.location + (keepPrefix ? prefixLength : 0),
            length: current.word.utf16.count + (!keepPrefix ? prefixLength : 0)
        )

        let text = messageView.text
        guard let range = Range(insertionRange, in: text) else { return }

        messageView.textView.text = text.replacingCharacters(in: range, with: autocomplete)
        messageView.textView.selectedRange = NSRange(
            location: insertionRange.location + autocomplete.utf16.count,
            length: 0
        )
    }

    public final var autocompleteMaxVisibleHeight: CGFloat = 200 {
        didSet {
            view.setNeedsLayout()
        }
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

        // required for the nested UITextView to layout its internals correctly
        messageView.layoutIfNeeded()

        scrollView.frame = CGRect(
            x: bounds.minX,
            y: bounds.minY,
            width: bounds.width,
            height: messageViewFrame.minY
        )

        let autocompleteHeight = min(autocompleteMaxVisibleHeight, autocompleteTableView.contentSize.height)
        autocompleteTableView.frame = CGRect(
            x: bounds.minX,
            y: messageViewFrame.minY - autocompleteHeight,
            width: bounds.width,
            height: autocompleteHeight
        )
    }

    internal func checkForAutocomplete() {
        guard let result = messageView.textView.find(prefixes: registeredPrefixes) else {
            cancelAutocomplete()
            return
        }
        let wordWithoutPrefix = (result.word as NSString).substring(from: result.prefix.utf16.count)
        currentAutocomplete = CurrentAutocomplete(prefix: result.prefix, word: wordWithoutPrefix, range: result.range)
        autocompleteDelegate?.didFind(prefix: result.prefix, word: wordWithoutPrefix)
    }

    internal func cancelAutocomplete() {
        currentAutocomplete = nil
        showAutocomplete(false)
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
