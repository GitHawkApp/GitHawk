//
//  MessageView+UITextViewDelegate.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension MessageView: UITextViewDelegate {

    public func textViewDidChange(_ textView: UITextView) {
        updateEmptyTextStates()
    }

    public func textViewDidChangeSelection(_ textView: UITextView) {
        delegate?.selectionDidChange(messageView: self)
    }

}
