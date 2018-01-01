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
    public let tableView = UITableView()

    public weak var delegate: MessageAutocompleteControllerDelegate?
    public weak var layoutDelegate: MessageAutocompleteControllerLayoutDelegate?

    public struct Selection {
        public let prefix: String
        public let word: String
        public let range: NSRange
    }
    public private(set) var selection: Selection?

    internal var registeredPrefixes = Set<String>()
    internal let border = CALayer()
    internal var keyboardHeight: CGFloat = 0

    public init(textView: MessageTextView) {
        self.textView = textView
        textView.add(listener: self)

        tableView.isHidden = true
        border.isHidden = true

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

    public final func show(_ doShow: Bool) {
        if doShow {
            tableView.reloadData()
            tableView.layoutIfNeeded()
        }
        tableView.isHidden = !doShow
        border.isHidden = !doShow
        layoutDelegate?.needsLayout(controller: self)
    }

    public final func accept(autocomplete: String, keepPrefix: Bool = true) {
        defer { cancel() }

        guard let selection = self.selection,
            let text = textView.text
            else { return }

        let prefixLength = selection.prefix.utf16.count
        let insertionRange = NSRange(
            location: selection.range.location + (keepPrefix ? prefixLength : 0),
            length: selection.word.utf16.count + (!keepPrefix ? prefixLength : 0)
        )

        guard let range = Range(insertionRange, in: text) else { return }

        textView.text = text.replacingCharacters(in: range, with: autocomplete)
        textView.selectedRange = NSRange(
            location: insertionRange.location + autocomplete.utf16.count,
            length: 0
        )
    }

    internal func cancel() {
        selection = nil
        show(false)
    }

    public final var maxHeight: CGFloat = 200 {
        didSet { layoutDelegate?.needsLayout(controller: self) }
    }

    public func layout(in view: UIView, bottomY: CGFloat? = nil) {
        if tableView.superview != view {
            view.addSubview(tableView)
            view.layer.addSublayer(border)
        }

        let bounds = view.bounds
        let pinY = bottomY ?? (bounds.height - keyboardHeight)

        let height = min(maxHeight, tableView.contentSize.height)
        let frame = CGRect(
            x: bounds.minX,
            y: pinY - height,
            width: bounds.width,
            height: height
        )
        tableView.frame = frame

        let borderHeight = 1 / UIScreen.main.scale

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        border.frame = CGRect(
            x: bounds.minX,
            y: frame.minY - borderHeight,
            width: bounds.width,
            height: borderHeight
        )
        CATransaction.commit()
    }

    public var borderColor: UIColor? {
        get {
            guard let color = border.backgroundColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            border.backgroundColor = newValue?.cgColor
        }
    }

    // MARK: Private API

    internal func check() {
        guard let result = textView.find(prefixes: registeredPrefixes) else {
            cancel()
            return
        }
        let wordWithoutPrefix = (result.word as NSString).substring(from: result.prefix.utf16.count)
        selection = Selection(prefix: result.prefix, word: wordWithoutPrefix, range: result.range)

        delegate?.didFind(controller: self, prefix: result.prefix, word: wordWithoutPrefix)
    }

    @objc internal func keyboardWillChangeFrame(notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        keyboardHeight = keyboardFrame.height
    }

    // MARK: MessageTextViewListener

    public func didChangeSelection(textView: MessageTextView) {
        check()
    }

    public func didChange(textView: MessageTextView) {}

}
