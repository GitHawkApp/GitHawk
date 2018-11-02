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
        DispatchQueue.global().async {
            let maybeHighlighted: NSAttributedString?
            if let language = language {
                maybeHighlighted = GithubHighlighting.highlight(code, as: language)
            } else {
                // Automatic language detection
                maybeHighlighted = GithubHighlighting.highlight(code)
            }
            guard let highlighted = maybeHighlighted else { return }
            DispatchQueue.main.async { [weak self] in
                self?.set(attributedCode: highlighted)
            }
        }
    }

    func set(attributedCode: NSAttributedString) {
        attributedText = attributedCode
    }

}
