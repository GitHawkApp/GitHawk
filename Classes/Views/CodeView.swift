//
//  CodeView.swift
//  Freetime
//
//  Created by Ryan Nystrom on 11/26/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class CodeView: UIScrollView {

    private lazy var textView: UITextView = {
        let view = UITextView()
        view.font = Styles.Fonts.code
        view.isScrollEnabled = false
        view.isEditable = false
        view.contentInset = .zero
        view.textContainerInset = UIEdgeInsets(
            top: Styles.Sizes.rowSpacing,
            left: Styles.Sizes.columnSpacing,
            bottom: Styles.Sizes.rowSpacing,
            right: Styles.Sizes.columnSpacing
        )
        self.addSubview(view)
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        isDirectionalLockEnabled = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public API

    func set(code: String) {
        set(attributedCode: NSAttributedString(
            string: code,
            attributes: [
                .font: Styles.Fonts.code,
                .foregroundColor: Styles.Colors.Gray.dark.color,
            ]))
    }

    func set(code: String, language: String?) {
        if let language = language,
            let highlighted = GithubHighlighting.highlight(code, as: language) {
            set(attributedCode: highlighted)
        } else {
            set(code: code)
        }
    }

    func set(attributedCode: NSAttributedString) {
        textView.attributedText = attributedCode
        let max = CGFloat.greatestFiniteMagnitude
        let size = textView.sizeThatFits(CGSize(width: max, height: max))
        textView.frame = CGRect(origin: .zero, size: size)
        contentSize = size
    }

}
