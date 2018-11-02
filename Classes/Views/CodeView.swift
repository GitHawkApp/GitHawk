//
//  CodeView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class CodeView: UITextView {

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)

        backgroundColor = .clear

        font = Styles.Text.code.preferredFont
        isEditable = false
        contentInset = .zero
        textContainerInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing,
            left: Styles.Sizes.columnSpacing,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.columnSpacing
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API
    func set(code: String, language: String? = nil) {
        if let language = language,
            let highlighted = GithubHighlighting.highlight(code, as: language) {
            set(attributedCode: highlighted)
        } else {
            // Automatic language detection
            if let highlighted = GithubHighlighting.highlight(code) {
                set(attributedCode: highlighted)
            }
        }
    }

    func set(attributedCode: NSAttributedString) {
        attributedText = attributedCode
    }

}
