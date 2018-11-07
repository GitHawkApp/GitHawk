//
//  MessageViewController+MessageViewDelegate.swift
//  MessageView
//
//  Created by Ryan Nystrom on 12/22/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension MessageViewController: MessageViewDelegate {

    internal func sizeDidChange(messageView: MessageView) {
        UIView.animate(withDuration: 0.25) {
            self.layout(updateOffset: true)
        }
    }

    internal func wantsLayout(messageView: MessageView) {
        view.setNeedsLayout()
    }

    internal func selectionDidChange(messageView: MessageView) {}

}
