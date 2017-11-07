//
//  EditCommentViewController.swift
//  Freetime
//
//  Created by Ryan Nystrom on 10/8/17.
//  Copyright © 2017 Ryan Nystrom. All rights reserved.
//

import UIKit
import SnapKit

protocol EditCommentViewControllerDelegate: class {
    func didEditComment(viewController: EditCommentViewController, markdown: String)
    func didCancel(viewController: EditCommentViewController)
}

class EditCommentViewController: UIViewController {

    weak var delegate: EditCommentViewControllerDelegate?

    private let commentID: Int
    private let client: GithubClient
    private let textView = UITextView()
    private let textActionsController = TextActionsController()
    private let issueModel: IssueDetailsModel
    private let isRoot: Bool
    private let originalMarkdown: String

    init(
        client: GithubClient,
        markdown: String,
        issueModel: IssueDetailsModel,
        commentID: Int,
        isRoot: Bool
        ) {
        self.client = client
        self.issueModel = issueModel
        self.commentID = commentID
        self.isRoot = isRoot
        self.originalMarkdown = markdown
        super.init(nibName: nil, bundle: nil)
        textView.text = markdown
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.githawkConfigure(inset: true)
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }

        setupInputView()

        title = NSLocalizedString("Edit Comment", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(EditCommentViewController.onCancel)
        )
        setRightBarItemIdle()

        let nc = NotificationCenter.default
        nc.addObserver(
            self,
            selector: #selector(EditCommentViewController.onKeyboardWillShow(notification:)),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        nc.addObserver(
            self,
            selector: #selector(EditCommentViewController.onKeyboardWillHide(notification:)),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    // MARK: Private API

    func setRightBarItemIdle() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("Save", comment: ""),
            style: .done,
            target: self,
            action: #selector(EditCommentViewController.onSave)
        )
    }

    func setupInputView() {
        let getMarkdownBlock = { [weak self] () -> (String) in
            return self?.textView.text ?? ""
        }
        let actions = IssueTextActionsView.forMarkdown(
            viewController: self,
            getMarkdownBlock: getMarkdownBlock,
            repo: issueModel.repo,
            owner: issueModel.repo,
            addBorder: true,
            supportsImageUpload: false
        )
        textActionsController.configure(client: client, textView: textView, actions: actions)
        textView.inputAccessoryView = actions
    }

    @objc func onCancel() {
        textView.resignFirstResponder()

        let dismissBlock = { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.delegate?.didCancel(viewController: strongSelf)
        }

        // if text unchanged, just dismiss
        if originalMarkdown == textView.text {
            dismissBlock()
        } else {
            let alert = UIAlertController(
                title: NSLocalizedString("Unsaved Changes", comment: ""),
                message: NSLocalizedString("Are you sure you want to discard your edit? Your changes will be lost.", comment: ""),
                preferredStyle: .alert
            )
            alert.addActions([
                AlertAction.goBack(),
                AlertAction.discard { _ in
                    dismissBlock()
                }
                ])
            present(alert, animated: true, completion: nil)
        }
    }

    @objc func onSave() {
        setRightBarItemSpinning()
        textView.isEditable = false
        textView.resignFirstResponder()
        let markdown = textView.text ?? ""
        client.editComment(
            owner: issueModel.owner,
            repo: issueModel.repo,
            issueNumber: issueModel.number,
            commentID: commentID,
            body: markdown,
            isRoot: isRoot
        ) { [weak self] (result) in
            switch result {
            case .success: self?.didSave(markdown: markdown)
            case .error: self?.error()
            }
        }
    }

    func didSave(markdown: String) {
        navigationItem.rightBarButtonItem = nil
        delegate?.didEditComment(viewController: self, markdown: markdown)
    }

    func error() {
        setRightBarItemIdle()
        ToastManager.showGenericError()
    }

    // MARK: Notifications

    @objc func onKeyboardWillShow(notification: NSNotification) {
        guard let frame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect else { return }
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        textView.contentInset = inset
        textView.scrollIndicatorInsets = inset
    }

    @objc func onKeyboardWillHide(notification: NSNotification) {
        textView.contentInset = .zero
        textView.scrollIndicatorInsets = .zero
    }

}
