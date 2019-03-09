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
    
    /// Adds an additional space after the autocompleted text when true. Default value is `TRUE`
    public var appendSpaceOnCompletion = true
    
    /// The text attributes applied to highlighted substrings for each prefix
    private var autocompleteTextAttributes: [String: [NSAttributedString.Key: Any]] = [:]
    
    /// A key used for referencing which substrings were autocompletes
    private let NSAttributedAutocompleteKey = NSAttributedString.Key.init("com.messageviewcontroller.autocompletekey")

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
            name: UIResponder.keyboardWillChangeFrameNotification,
            object: nil
        )
    }

    // MARK: Public API

    public final func register(prefix: String) {
        registeredPrefixes.insert(prefix)
    }

    public final func show(_ doShow: Bool) {
        tableView.reloadData()
        tableView.layoutIfNeeded()
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
        
        // Create an NSRange to use with attributedText replacement
        let nsrange = NSRange(range, in: textView.text)
        insertAutocomplete(autocomplete, at: selection, for: nsrange, keepPrefix: keepPrefix)
        
        let selectedLocation = insertionRange.location + autocomplete.utf16.count + (appendSpaceOnCompletion ? 1 : 0)

        textView.selectedRange = NSRange(
            location: selectedLocation,
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

    public func registerAutocomplete(prefix: String, attributes: [NSAttributedString.Key: Any]) {
        registeredPrefixes.insert(prefix)
        autocompleteTextAttributes[prefix] = attributes
    }

    // MARK: Private API
    
    private func insertAutocomplete(_ autocomplete: String, at selection: Selection, for range: NSRange, keepPrefix: Bool) {
        let defaultTypingTextAttributes = textView.typingAttributes

        var attrs = defaultTypingTextAttributes
        attrs[NSAttributedAutocompleteKey] = true

        if let autoAttrs = autocompleteTextAttributes[selection.prefix] {
            for (k, v) in autoAttrs {
                attrs[k] = v
            }
        }

        let newString = (keepPrefix ? selection.prefix : "") + autocomplete
        let newAttributedString = NSAttributedString(string: newString, attributes: attrs)
        
        // Modify the NSRange to include the prefix length
        let rangeModifier = keepPrefix ? selection.prefix.count : 0
        let highlightedRange = NSRange(location: range.location - rangeModifier, length: range.length + rangeModifier)
        
        // Replace the attributedText with a modified version including the autocompete
        let newAttributedText = textView.attributedText.replacingCharacters(in: highlightedRange, with: newAttributedString)
        if appendSpaceOnCompletion {
            newAttributedText.append(NSAttributedString(string: " ", attributes: defaultTypingTextAttributes))
        }

        // set to a blank attributed string to prevent keyboard autocorrect from cloberring the insert
        textView.attributedText = NSAttributedString()

        textView.attributedText = newAttributedText
    }

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
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
            else { return }
        keyboardHeight = keyboardFrame.height
    }

    // MARK: MessageTextViewListener

    public func didChangeSelection(textView: MessageTextView) {
        check()
    }

    public func didChange(textView: MessageTextView) {}
    
    public func willChangeRange(textView: MessageTextView, to range: NSRange) {
        
        // range.length == 1: Remove single character
        // range.lowerBound < textView.selectedRange.lowerBound: Ignore trying to delete
        //      the substring if the user is already doing so
        if range.length == 1, range.lowerBound < textView.selectedRange.lowerBound {
            
            // Backspace/removing text
            let attribute = textView.attributedText
                .attributes(at: range.lowerBound, longestEffectiveRange: nil, in: range)
                .filter { return $0.key == NSAttributedAutocompleteKey }

            if let isAutocomplete = attribute[NSAttributedAutocompleteKey] as? Bool, isAutocomplete {
                // Remove the autocompleted substring
                let lowerRange = NSRange(location: 0, length: range.location + 1)
                textView.attributedText.enumerateAttribute(NSAttributedAutocompleteKey, in: lowerRange, options: .reverse, using: { (_, range, stop) in

                    // Only delete the first found range
                    defer { stop.pointee = true }

                    let emptyString = NSAttributedString(string: "", attributes: textView.typingAttributes)
                    textView.attributedText = textView.attributedText.replacingCharacters(in: range, with: emptyString)
                    textView.selectedRange = NSRange(location: range.location, length: 0)
                })
            }
        }
    }
}


