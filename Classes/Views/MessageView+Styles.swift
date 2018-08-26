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

    func configure() {
        borderColor = Styles.Colors.Gray.border.color
        messageView.textView.placeholderText = NSLocalizedString("Leave a comment", comment: "")
        messageView.textView.placeholderTextColor = Styles.Colors.Gray.light.color
        messageView.font = Styles.Text.body.preferredFont
        messageView.textViewInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing*1.5,
            left: Styles.Sizes.gutter,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.gutter
        )
        messageView.bottomInset = Styles.Sizes.rowSpacing / 2
        messageView.maxLineCount = 10
    }

}
