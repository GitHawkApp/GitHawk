//
//  MessageAutocompleteController.swift
//  MessageViewController
//
//  Created by Ryan Nystrom on 12/31/17.
//

import UIKit

public protocol MessageAutocompleteControllerDelegate: class {
    func didFind(controller: MessageAutocompleteController, prefix: String, word: String)
}

public protocol MessageAutocompleteControllerLayoutDelegate: class {
    func needsLayout(controller: MessageAutocompleteController)
}

public final class MessageAutocompleteController: MessageTextViewListener {

    public let textView: MessageTextView
    public let autocompleteTableView = UITableView()

    public weak var delegate: MessageAutocompleteControllerDelegate?
    public weak var layoutDelegate: MessageAutocompleteControllerLayoutDelegate?

    public struct CurrentAutocomplete {
        public let prefix: String
        public let word: String
        public let range: NSRange
    }
    public private(set) var currentAutocomplete: CurrentAutocomplete?

    internal var registeredPrefixes = Set<String>()
    internal let autocompleteBorder = CALayer()
    internal var keyboardHeight: CGFloat = 0

    init(textView: MessageTextView) {
        self.textView = textView
        textView.add(listener: self)

        autocompleteTableView.isHidden = true
        autocompleteBorder.isHidden = true

        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(
            self,
            selector: #selector(keyboardWillChangeFrame(notification:)),
            name: NSNotification.Name.UIKeyboardWillChangeFrame,
            object: nil
        )
    }

    // MARK: Public API

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
        layoutDelegate?.needsLayout(controller: self)
    }

    public final func accept(autocomplete: String, keepPrefix: Bool = true) {
        defer { cancelAutocomplete() }

        guard let current = currentAutocomplete,
            let text = textView.text
            else { return }

        let prefixLength = current.prefix.utf16.count
        let insertionRange = NSRange(
            location: current.range.location + (keepPrefix ? prefixLength : 0),
            length: current.word.utf16.count + (!keepPrefix ? prefixLength : 0)
        )

        guard let range = Range(insertionRange, in: text) else { return }

        textView.text = text.replacingCharacters(in: range, with: autocomplete)
        textView.selectedRange = NSRange(
            location: insertionRange.location + autocomplete.utf16.count,
            length: 0
        )
    }

    internal func cancelAutocomplete() {
        currentAutocomplete = nil
        showAutocomplete(false)
    }

    public final var autocompleteMaxVisibleHeight: CGFloat = 200 {
        didSet { layoutDelegate?.needsLayout(controller: self) }
    }

    public func layout(in view: UIView, bottomY: CGFloat? = nil) {
        if autocompleteTableView.superview != view {
            view.addSubview(autocompleteTableView)
            view.layer.addSublayer(autocompleteBorder)
        }

        let bounds = view.bounds
        let pinY = bottomY ?? (bounds.height - keyboardHeight)

        let autocompleteHeight = min(autocompleteMaxVisibleHeight, autocompleteTableView.contentSize.height)
        let autocompleteFrame = CGRect(
            x: bounds.minX,
            y: pinY - autocompleteHeight,
            width: bounds.width,
            height: autocompleteHeight
        )
        autocompleteTableView.frame = autocompleteFrame

        let borderHeight = 1 / UIScreen.main.scale

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        autocompleteBorder.frame = CGRect(
            x: bounds.minX,
            y: autocompleteFrame.minY - borderHeight,
            width: bounds.width,
            height: borderHeight
        )
        CATransaction.commit()
    }

    public var borderColor: UIColor? {
        get {
            guard let color = autocompleteBorder.backgroundColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            autocompleteBorder.backgroundColor = newValue?.cgColor
        }
    }

    // MARK: Private API

    internal func checkForAutocomplete() {
        guard let result = textView.find(prefixes: registeredPrefixes) else {
            cancelAutocomplete()
            return
        }
        let wordWithoutPrefix = (result.word as NSString).substring(from: result.prefix.utf16.count)
        currentAutocomplete = CurrentAutocomplete(prefix: result.prefix, word: wordWithoutPrefix, range: result.range)

        delegate?.didFind(controller: self, prefix: result.prefix, word: wordWithoutPrefix)
    }

    @objc internal func keyboardWillChangeFrame(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        keyboardHeight = keyboardFrame.height
    }

    // MARK: MessageTextViewListener

    public func didChangeSelection(textView: MessageTextView) {
        checkForAutocomplete()
    }

    public func didChange(textView: MessageTextView) {}

}
