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
    }

    // MARK: Public API

    public final func setup(scrollView: UIScrollView) {
        self.scrollView = scrollView

        if scrollView.superview != view {
            view.addSubview(scrollView)
        }
        scrollView.panGestureRecognizer.addTarget(self, action: #selector(onPan(gesture:)))
        scrollView.keyboardDismissMode = .none

        view.addSubview(autocompleteTableView)
        view.layer.addSublayer(autocompleteBorder)
        view.addSubview(messageView)

        autocompleteTableView.isHidden = true
        autocompleteBorder.isHidden = true
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
        autocompleteBorder.isHidden = !doShow
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
        didSet { view.setNeedsLayout() }
    }

    public var borderColor: UIColor? {
        get {
            guard let color = autocompleteBorder.backgroundColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            autocompleteBorder.backgroundColor = newValue?.cgColor
            messageView.topBorderLayer.backgroundColor = newValue?.cgColor
        }
    }

    public func setMessageView(hidden: Bool, animated: Bool) {
        isMessageViewHidden = hidden
        UIView.animate(withDuration: animated ? 0.25 : 0) {
            self.layout()
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
    internal var isMessageViewHidden = false

    // autocomplete
    public struct CurrentAutocomplete {
        public let prefix: String
        public let word: String
        public let range: NSRange
    }
    internal var registeredPrefixes = Set<String>()
    public private(set) var currentAutocomplete: CurrentAutocomplete?
    private let autocompleteBorder = CALayer()

    internal func commonInit() {
        messageView.delegate = self

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardDidChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardDidChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        notificationCenter.addObserver(self, selector: #selector(appWillResignActive(notification:)), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }

    internal var safeAreaAdditionalHeight: CGFloat {
        switch keyboardState {
        case .hiding, .resigned: return view.util_safeAreaInsets.bottom
        case .showing, .visible: return 0
        }
    }

    internal func layout() {
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

        scrollView.frame = CGRect(
            x: bounds.minX,
            y: bounds.minY,
            width: bounds.width,
            height: messageViewFrame.minY
        )

        let autocompleteHeight = min(autocompleteMaxVisibleHeight, autocompleteTableView.contentSize.height)
        let autocompleteFrame = CGRect(
            x: bounds.minX,
            y: messageViewFrame.minY - autocompleteHeight,
            width: bounds.width,
            height: autocompleteHeight
        )
        autocompleteTableView.frame = autocompleteFrame

        let borderHeight = 1 / UIScreen.main.scale
        UIView.performWithoutAnimation {
            autocompleteBorder.frame = CGRect(
                x: bounds.minX,
                y: autocompleteFrame.minY - borderHeight,
                width: bounds.width,
                height: borderHeight
            )
        }
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

    internal var fullCacheKey: String? {
        guard let key = cacheKey else { return nil }
        return "com.freetime.MessageViewController.\(key)"
    }

    internal func cache() {
        guard let key = fullCacheKey else { return }
        UserDefaults.standard.set(messageView.text, forKey: key)
    }

    var cachedText: String? {
        guard let key = fullCacheKey else { return nil }
        return UserDefaults.standard.string(forKey: key)
    }

    // MARK: Keyboard notifications

    @objc internal func keyboardWillShow(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let animationDuration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
            else { return }

        scrollView.stopScrolling()
        keyboardState = .showing

        let previousKeyboardHeight = keyboardHeight
        keyboardHeight = keyboardFrame.height

        UIView.animate(withDuration: animationDuration) {
            // capture before changing the frame which might have weird side effects
            let contentOffset = self.scrollView.contentOffset.y

            self.layout()

            let scrollViewHeight = self.scrollView.bounds.height
            let contentHeight = self.scrollView.contentSize.height
            let topInset = self.scrollView.util_adjustedContentInset.top
            let bottomSafeInset = self.view.util_safeAreaInsets.bottom

            let newOffset = max(
                min(
                    contentHeight - scrollViewHeight,
                    contentOffset + self.keyboardHeight - previousKeyboardHeight - bottomSafeInset
                ),
                -topInset
            )
            self.scrollView.contentOffset = CGPoint(x: 0, y: newOffset)
        }
    }

    // MARK: Notifications

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

}
