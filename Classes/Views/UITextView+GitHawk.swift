//
//  UITextView+GitHawk.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

extension UITextView {

    func githawkConfigure(inset: Bool = false) {
        contentInset = .zero
        textContainerInset = inset
            ? UIEdgeInsets(
                top: Styles.Sizes.rowSpacing,
                left: Styles.Sizes.gutter,
                bottom: Styles.Sizes.rowSpacing,
                right: Styles.Sizes.gutter
                )
            : .zero
        textContainer.lineFragmentPadding = 0
        font = Styles.Text.body.preferredFont
    }

}
