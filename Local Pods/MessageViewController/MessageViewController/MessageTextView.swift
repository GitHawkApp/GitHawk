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
}

open class MessageTextView: UITextView, UITextViewDelegate {

    private var listeners: NSHashTable<AnyObject> = NSHashTable.weakObjects()

    open override var delegate: UITextViewDelegate? {
        get { return self }
        set {}
    }

    // MARK: Public API

    public func add(listener: MessageTextViewListener) {
        assert(Thread.isMainThread)
        listeners.add(listener)
    }

    // MARK: Private API

    private func enumerateListeners(block: (MessageTextViewListener) -> Void) {
        for listener in listeners.objectEnumerator() {
            guard let listener = listener as? MessageTextViewListener else { continue }
            block(listener)
        }
    }

    // MARK: UITextViewDelegate

    public func textViewDidChange(_ textView: UITextView) {
        enumerateListeners { $0.didChange(textView: self) }
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        enumerateListeners { $0.didChangeSelection(textView: self) }
    }

}
