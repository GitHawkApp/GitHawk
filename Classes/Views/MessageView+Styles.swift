//
//  MessageView+Styles.swift
//  Freetime
//
//  Created by Ryan Nystrom on 2/4/18.
//  Copyright © 2018 Ryan Nystrom. All rights reserved.
//

import Foundation
import MessageViewController

extension MessageViewController {

    func configure(target: Any, action: Selector) {
        // setup message view properties
        borderColor = Styles.Colors.Gray.border.color
        messageView.textView.placeholderText = NSLocalizedString("Leave a comment", comment: "")
        messageView.textView.placeholderTextColor = Styles.Colors.Gray.light.color
        messageView.set(buttonIcon: UIImage(named: "send")?.withRenderingMode(.alwaysTemplate), for: .normal)
        messageView.buttonTint = Styles.Colors.Blue.medium.color
        messageView.font = Styles.Text.body.preferredFont
        messageView.inset = UIEdgeInsets(
            top: Styles.Sizes.gutter,
            left: Styles.Sizes.gutter,
            bottom: Styles.Sizes.rowSpacing / 2,
            right: Styles.Sizes.gutter
        )
        messageView.addButton(target: target, action: action)
    }

}
