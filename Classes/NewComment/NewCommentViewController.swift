//
//  NewCommentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class NewCommentViewController: UIViewController, UITextViewDelegate {

    private let placeholderLabel = UILabel()
    private let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = NSLocalizedString("New Comment", comment: "")

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(NewCommentViewController.onCancel)
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Send", comment: ""),
            style: .done,
            target: self,
            action: #selector(NewCommentViewController.onSend)
        )

        placeholderLabel.textColor = Styles.Colors.Gray.light.color
        placeholderLabel.text = NSLocalizedString("Leave a comment", comment: "")
        placeholderLabel.sizeToFit()
        placeholderLabel.font = Styles.Fonts.body
        textView.addSubview(placeholderLabel)

        textView.alwaysBounceVertical = true
        textView.delegate = self
        textView.font = Styles.Fonts.body
        textView.backgroundColor = .clear
        view.addSubview(textView)

        updateState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textView.frame = view.bounds

        let inset = UIEdgeInsets(
            top: Styles.Sizes.gutter,
            left: Styles.Sizes.gutter,
            bottom: 0,
            right: Styles.Sizes.gutter + Styles.Sizes.gutter
        )
        textView.textContainerInset = inset

        var placeholderFrame = placeholderLabel.frame
        // extra inset past the selected range indicator
        placeholderFrame.origin.x = inset.left + 7
        placeholderFrame.origin.y = inset.top - 1
        placeholderLabel.frame = placeholderFrame
    }

    // MARK: Private API

    var hasText: Bool {
        return textView.text.characters.count > 0
    }

    func updateState() {
        let hasText = self.hasText
        navigationItem.rightBarButtonItem?.isEnabled = hasText
        placeholderLabel.isHidden = hasText
    }

    func onCancel() {
        textView.resignFirstResponder()

        if hasText {
            let alert = UIAlertController(
                title: NSLocalizedString("Discard comment", comment: ""),
                message: NSLocalizedString("Are you sure you want to cancel and lose your comment?", comment: ""),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: Strings.cancel, style: .cancel))
            alert.addAction(UIAlertAction(
                title: NSLocalizedString("Discard", comment: ""),
                style: .destructive,
                handler: { _ in
                    self.dismiss(animated: true)
            }))
            present(alert, animated: true)
        } else {
            dismiss(animated: true)
        }
    }

    func onSend() {

    }

    // MARK: UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
        updateState()
    }

}
