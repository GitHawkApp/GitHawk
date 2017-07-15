//
//  NewCommentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 7/14/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit

final class NewCommentViewController: UIViewController, UITextViewDelegate, AddCommentListener {

    private let client: AddCommentClient
    private let placeholderLabel = UILabel()
    private let textView = UITextView()
    private let textViewInsets = UIEdgeInsets(
        top: Styles.Sizes.gutter,
        left: Styles.Sizes.gutter,
        bottom: 0,
        right: Styles.Sizes.gutter + Styles.Sizes.gutter
    )
    private let formattingController = MDownFormattingController()

    init(client: AddCommentClient) {
        self.client = client
        super.init(nibName: nil, bundle: nil)
        client.addListener(listener: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = NSLocalizedString("New Comment", comment: "")

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(NewCommentViewController.onCancel)
        )
        update(sending: false)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(NewCommentViewController.onKeyboardDidShow(notification:)),
            name: NSNotification.Name.UIKeyboardDidShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(NewCommentViewController.onKeyboardWillHide(notification:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )

        placeholderLabel.textColor = Styles.Colors.Gray.light.color
        placeholderLabel.text = NSLocalizedString("Leave a comment", comment: "")
        placeholderLabel.accessibilityHint = NSLocalizedString("Placeholder text", comment: "")
        placeholderLabel.sizeToFit()
        placeholderLabel.font = Styles.Fonts.body
        textView.addSubview(placeholderLabel)

        textView.textContainerInset = textViewInsets
        textView.alwaysBounceVertical = true
        textView.delegate = self
        textView.font = Styles.Fonts.body
        textView.backgroundColor = .clear
        textView.inputAccessoryView = formattingController.view
        formattingController.textView = textView
        // need to constraint here, maybe better idea swhere else
        // Otherwise takes all screen
        textView.inputAccessoryView?.frame = CGRect(origin: .zero, size: CGSize(width: 0.0, height: 44.0))
        view.addSubview(textView)

        updateTextState()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textView.frame = view.bounds

        var placeholderFrame = placeholderLabel.frame
        // extra inset past the selected range indicator
        placeholderFrame.origin.x = textViewInsets.left + 7
        placeholderFrame.origin.y = textViewInsets.top - 1
        placeholderLabel.frame = placeholderFrame
    }

    // MARK: Private API

    func update(sending: Bool) {
        textView.isEditable = !sending

        if sending {
            textView.resignFirstResponder()
        }

        if sending {
            let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            activity.startAnimating()
            navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activity)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: NSLocalizedString("Send", comment: ""),
                style: .done,
                target: self,
                action: #selector(NewCommentViewController.onSend)
            )
        }
    }

    func restoreTextViewInsets() {
        textView.textContainerInset = textViewInsets
        textView.scrollIndicatorInsets = .zero
    }

    var hasText: Bool {
        return textView.text.characters.count > 0
    }

    func updateTextState() {
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
        update(sending: true)
        client.addComment(body: textView.text)
    }

    func onKeyboardDidShow(notification: NSNotification) {
        guard let size = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect)?.size else { return }
        var inset = textView.textContainerInset
        inset.bottom = size.height + Styles.Sizes.gutter
        textView.textContainerInset = inset

        var scrollInset = UIEdgeInsets.zero
        scrollInset.bottom = size.height
        textView.scrollIndicatorInsets = scrollInset
    }

    func onKeyboardWillHide(notification: NSNotification) {
        textView.textContainerInset = textViewInsets
    }

    // MARK: UITextViewDelegate

    func textViewDidChange(_ textView: UITextView) {
        updateTextState()
    }

    // MARK: AddCommentListener

    func didSendComment(client: AddCommentClient, id: String, commentFields: CommentFields, reactionFields: ReactionFields) {
        update(sending: false)
        dismiss(animated: true)
    }

    func didFailSendingComment(client: AddCommentClient) {
        update(sending: false)
    }

}
